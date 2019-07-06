//
//  Pokemon.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/5/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import Foundation

struct Pokemon {
    var id: Int?
    var name: String
    var height: Int?
    var weight: Int?
    var baseExperience: Int?
    var sprites: [String: String] = [String: String]()
    var missingData: Bool = false
    
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
    }
    
    init(withName name: String) {
        self.name = name
        missingData = true
    }
}
