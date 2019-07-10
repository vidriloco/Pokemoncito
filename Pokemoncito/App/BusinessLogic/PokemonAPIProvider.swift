//
//  PokemonAPIProvider.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/1/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import Foundation

// MARK - Specific error types for resource
enum APIResourceProviderError: Error {
    case undecodableResponseError
    case unexpectedError
}

// MARK - API requests definitions
class PokemonAPIProvider : APIResourceProvider {
    
    private let providerURL = "pokeapi.co"
    private let decoder = JSONDecoder()
    private var isBusyFetchingPokemons = false
    
    var delegate: APIResourceProviderDelegate?
    
    func fetchPokemons(limit: Int = 20, offset: Int = 0, completion: @escaping ([Pokemon]) -> Void, failure: @escaping () -> Void) {
        
        if isBusyFetchingPokemons {
            return
        }
        isBusyFetchingPokemons = true
        
        let dispatchGroup = DispatchGroup()

        fetchPokemonNamesList(limit: limit, offset: offset, completion: { pokemonReferenceList in
            
            var pokemons = [Pokemon]()
            
            pokemonReferenceList.forEach({ [weak self] pokemonReference in
                
                guard let self = self else { return }
                
                dispatchGroup.enter()
                self.fetchDescriptionForPokemon(named: pokemonReference.name, completion: { (pokemonFromAPI) in
                    pokemons.append(Pokemon(withPokemon: pokemonFromAPI))
                    
                    dispatchGroup.leave()
                }, failure: {
                    pokemons.append(Pokemon(withName: pokemonReference.name))
                    
                    dispatchGroup.leave()
                })
            })
            
            dispatchGroup.notify(queue: .main, execute: {
                completion(pokemons)
                self.isBusyFetchingPokemons = false
            })
        }) {
            dispatchGroup.notify(queue: .main, execute: {
                failure()
                self.isBusyFetchingPokemons = false
            })
        }
    }
    
    private func fetchPokemonNamesList(limit: Int = 20, offset: Int = 0, completion: @escaping ([PokemonNamesResult]) -> Void, failure: @escaping () -> Void) {
        
        let params = ["offset": "\(offset)", "limit": "\(limit)"]
        let endPoint = APIEndpoint(host: providerURL, path: "/api/v2/pokemon").with(params: params)
        let apiClient = APIJSONClient<PokemonNames>()
        
        apiClient.execute(at: endPoint) { response in
            switch response {
            case .success(let pokemonsResponse):
                completion(pokemonsResponse.results)
            case .fail:
                failure()
            }
        }
    }
    
    private func fetchDescriptionForPokemon(named name: String, completion: @escaping (PokemonBasicInfo) -> Void, failure: @escaping () -> Void) {
        
        let endPoint = APIEndpoint(host: providerURL, path: "/api/v2/pokemon/\(name)")
        let apiClient = APIJSONClient<PokemonBasicInfo>()
        
        apiClient.execute(at: endPoint) { response in
            switch response {
            case .success(let pokemonDetails):
                completion(pokemonDetails)
            case .fail:
                failure()
            }
        }
    }
    
}

// MARK - API Response type mappings
typealias PokemonNames = JSON.Pokemons.Names
typealias PokemonNamesResult = JSON.Pokemons.Names.Result
typealias PokemonBasicInfo = JSON.Pokemons.BasicInfo

// MARK - API Response structures
struct JSON {
    
    struct Pokemons: Decodable {
        
        struct Names: Decodable {
            let results: [Result]
            
            struct Result: Decodable {
                let name: String
            }
        }
        
        struct BasicInfo: Decodable {
            let id: Int
            let name: String
            let height: Int
            let weight: Int
            let baseExperience: Int
            let sprites: [String: String?]
            let types: [TypeDescription]
            
            struct TypeDescription: Decodable {
                let type: TypeObject
                
                struct TypeObject: Decodable {
                    let name: String
                }
            }
            
            private enum CodingKeys : String, CodingKey {
                case id, name, height, weight, baseExperience = "base_experience", sprites, types
            }
        }
    }
}
