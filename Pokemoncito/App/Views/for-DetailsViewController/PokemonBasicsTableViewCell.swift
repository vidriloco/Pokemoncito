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
        $0.spacing = 5
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
    
    private var numberLabel = UILabel().with {
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .white
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        }.withoutAutoConstraints()
    
    private var spriteImageView = UIImageView().with {
        $0.contentMode = .scaleAspectFit
    }.withoutAutoConstraints()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureWith(viewModel: ViewModel) {
        basicStatsStackView.removeAllArrangedSubviews()
        stackView.removeAllArrangedSubviews()
        
        if !contentView.subviews.contains(stackView) {
            contentView.addSubview(stackView)
        }
        
        backgroundColor = .clear
        
        spriteImageView.image = viewModel.pokemonImage
        
        let statViewModels = [
            TextStatsView.ViewModel(titleValue: viewModel.pokemonWeight, subtitleValue: "Weight"),
            TextStatsView.ViewModel(titleValue: viewModel.pokemonHeight, subtitleValue: "Height"),
            TextStatsView.ViewModel(titleValue: viewModel.pokemonXP, subtitleValue: "XP")]

        stackView.addArrangedSubview(spriteImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(numberLabel)
        stackView.addArrangedSubview(basicStatsStackView)
        
        statViewModels.forEach { statViewModel in
            if let statsView = Bundle.main.loadNibNamed("TextStatsView", owner: self, options: nil)?.first as? TextStatsView {
                statsView.configureWith(viewModel: statViewModel)
                basicStatsStackView.addArrangedSubview(statsView)
            }
        }

        titleLabel.text = viewModel.pokemonName
        
        if let pokemonIndex = viewModel.pokemonIndex {
            numberLabel.text = pokemonIndex
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        
        numberLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        numberLabel.setContentHuggingPriority(.required, for: .vertical)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 20),
            spriteImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        basicStatsStackView.setContentHuggingPriority(.required, for: .vertical)
    }
    
    struct ViewModel {
        private let pokemon: Pokemon
        
        var pokemonName: String {
            return pokemon.name.capitalized
        }
        
        var pokemonIndex: String? {
            if let idx = pokemon.id {
                return "#\(idx)"
            }
            return nil
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
            return UIImage(named: "Incognito")
        }
        
        init(withPokemon pokemon: Pokemon) {
            self.pokemon = pokemon
        }
    }
}
