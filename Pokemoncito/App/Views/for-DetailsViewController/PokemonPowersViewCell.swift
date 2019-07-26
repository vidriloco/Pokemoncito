//
//  PokemonPowersViewCell.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/24/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class PokemonPowersViewCell : UITableViewCell {
    
    let indicatorView = PanelBarIndicatorView().withoutAutoConstraints()
    
    struct ViewModel {
        private let pokemon: Pokemon
        
        init(withPokemon pokemon: Pokemon) {
            self.pokemon = pokemon
        }
        
        func powers() -> [BarIndicatorView.ViewModel] {
            return pokemon.powers.map { BarIndicatorView.ViewModel(colorValue: UIColor.red, titleValue: $0.key, numericValue: $0.value) }
        }
        
    }
    
    func configureWith(barsViewModels: [BarRepresentable]) {
        backgroundColor = .clear

        if !contentView.subviews.contains(indicatorView) {
            contentView.addSubview(indicatorView)
            setupConstraints(forModels: barsViewModels)
        }
    }
    
    private func setupConstraints(forModels barsViewModels: [BarRepresentable]) {
        NSLayoutConstraint.activate([
            indicatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: indicatorView.trailingAnchor, constant: 20),
            indicatorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentView.bottomAnchor.constraint(equalTo: indicatorView.bottomAnchor)
        ])
        
        indicatorView.configureWith(barsViewModels: barsViewModels, viewModel: PanelBarIndicatorView.ViewModel(title: "Pokemon's EVs".uppercased(), titleSpacing: 20, maximumBarMetric: 252))
    }
}
