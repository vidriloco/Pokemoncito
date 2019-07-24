//
//  Pokemon.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/5/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import Foundation

class Pokemon {
    var id: Int?
    var name: String
    var height: Int?
    var weight: Int?
    var baseExperience: Int?
    var sprites: [String: String] = [String: String]()
    var missingData: Bool = false
    var types: [String] = [String]()
    
    var mainImage: Data?
    var powers: [String: Float] = [String: Float]()
    
    init(withPokemon pokemon: PokemonBasicInfo) {
        id = pokemon.id
        name = pokemon.name
        height = pokemon.height
        weight = pokemon.weight
        baseExperience = pokemon.baseExperience
        
        pokemon.sprites.forEach({ (key, value) in
            if (value ?? "").count > 0 {
                sprites[key] = value
            }
        })
        
        pokemon.types.forEach { (pokemonType) in
            types.append(pokemonType.type.name)
        }
        
    }
    
    init(withName name: String) {
        self.name = name
        missingData = true
    }
    
    func add(powersList powers: [String: Float]) {
        self.powers = powers
    }
}
