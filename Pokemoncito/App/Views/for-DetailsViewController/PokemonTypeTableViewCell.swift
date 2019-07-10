//
//  PokemonTypeViewCell.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/10/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class PokemonTypeTableViewCell : UITableViewCell {
    
    private let stackView = UIStackView().with {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.alignment = .leading
        $0.spacing = 5
        }.withoutAutoConstraints()
    
    private let typesStatsStackView = UIStackView().with {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.spacing = 15
        }.withoutAutoConstraints()
    
    private var titleLabel = UILabel().with {
        $0.textAlignment = .justified
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.textColor = .white
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        }.withoutAutoConstraints()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureWith(viewModel: ViewModel) {
        backgroundColor = .clear
        
        viewModel.pokemonTypeList.forEach { pokemonTypeName in
            if let powerTypeView = Bundle.main.loadNibNamed("PowerTypeView", owner: self, options: nil)?.first as? PowerTypeView {
                powerTypeView.configureWith(viewModel: PowerTypeView.ViewModel(typeName: pokemonTypeName))
                typesStatsStackView.addArrangedSubview(powerTypeView)
            }
        }
        
        titleLabel.text = "Types this pokemon has:".uppercased()
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(typesStatsStackView)
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            contentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 30)
            ])
        
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
    }
    
    struct ViewModel {
        private let pokemon: Pokemon
        
        var pokemonTypeList: [String] {
            return pokemon.types
        }
        
        init(withPokemon pokemon: Pokemon) {
            self.pokemon = pokemon
        }
    }
}
