//
//  PokemonBasicsView.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/8/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class PokemonBasicsTableViewCell : UITableViewCell {
    
    private let stackView = UIStackView().with {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.alignment = .center
        $0.spacing = 25
    }.withoutAutoConstraints()
    
    private let basicStatsStackView = UIStackView().with {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.spacing = 10
    }.withoutAutoConstraints()
    
    private var titleLabel = UILabel().with {
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 40)
        $0.textColor = .white
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
    }.withoutAutoConstraints()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureWith(viewModel: ViewModel) {
        backgroundColor = .clear
        
        if let imageView = imageView {
            imageView.image = viewModel.pokemonImage
            imageView.contentMode = .scaleAspectFill
            stackView.addArrangedSubview(imageView)
        }
        
        let statViewModels = [
            StatsView.ViewModel(number: viewModel.pokemonWeight, units: "Weight"),
            StatsView.ViewModel(number: viewModel.pokemonHeight, units: "Height"),
            StatsView.ViewModel(number: viewModel.pokemonXP, units: "XP")]
        
        statViewModels.forEach { statViewModel in
            if let statsView = Bundle.main.loadNibNamed("StatsView", owner: self, options: nil)?.first as? StatsView {
                statsView.configureWith(viewModel: statViewModel)
                basicStatsStackView.addArrangedSubview(statsView)
            }
        }
        
        titleLabel.text = viewModel.pokemonName
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(basicStatsStackView)
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 20),
            contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
        
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    struct ViewModel {
        private let pokemon: Pokemon
        
        var pokemonName: String {
            return pokemon.name.capitalized
        }
        
        var pokemonHeight: String {
            if let height = pokemon.height {
                return "\(height/10) m"
            }
            
            return "0 m"
        }
        
        var pokemonWeight: String {
            if let weight = pokemon.weight {
                return "\(weight/10) kg"
            }
            
            return "0 kg"
        }
        
        var pokemonXP: String {
            if let xperience = pokemon.baseExperience {
                return "\(xperience) XP"
            }
            
            return "0 XP"
        }
        
        var pokemonImage: UIImage? {
            if let imageData = pokemon.mainImage {
                return UIImage(data: imageData)
            }
            
            return nil
        }
        
        init(withPokemon pokemon: Pokemon) {
            self.pokemon = pokemon
        }
    }
}
