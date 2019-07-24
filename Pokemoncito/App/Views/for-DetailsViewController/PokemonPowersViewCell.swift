//
//  PokemonPowersViewCell.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/24/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class PokemonPowersViewCell : UITableViewCell {
    
    struct ViewModel {
        private let pokemon: Pokemon
        
        init(withPokemon pokemon: Pokemon) {
            self.pokemon = pokemon
        }
        
        func powers() -> [BarIndicatorView.ViewModel] {
            return pokemon.powers.map { BarIndicatorView.ViewModel(colorValue: UIColor.red, titleValue: $0.key, numericValue: $0.value) }
        }
        
    }
    
}
