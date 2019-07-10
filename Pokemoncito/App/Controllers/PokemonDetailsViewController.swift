//
//  PokemonDetailsViewController.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/8/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class PokemonDetailsViewController : UITableViewController {
    
    private var detailsBlockList = [PokemonDetailBlock]()

    struct ReuseIdentifiers {
        static let forPokemonBasicDetailsCell = "PokemonDetailViewCell"
        static let forPokemonTypeCell = "PokemonTypeViewCell"
    }
    
    enum PokemonDetailBlock {
        case basic(Pokemon, Float)
        case types(Pokemon, Float)
    }
    
    struct BlockDetailsViewCell {
        static let basicHeight : Float = 300
        static let typesHeight : Float = 150
    }
    
    init(apiDevProvider: PokemonAPIProvider, pokemon: Pokemon) {
        super.init(nibName: nil, bundle: nil)
        
        detailsBlockList.append(.basic(pokemon, BlockDetailsViewCell.basicHeight))
        detailsBlockList.append(.types(pokemon, BlockDetailsViewCell.typesHeight))
        
        tableView.register(PokemonBasicsTableViewCell.self, forCellReuseIdentifier: ReuseIdentifiers.forPokemonBasicDetailsCell)
        tableView.register(PokemonTypeTableViewCell.self, forCellReuseIdentifier: ReuseIdentifiers.forPokemonTypeCell)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Pokemon details"
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
    }
}

extension PokemonDetailsViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemonDetailsBlock = detailsBlockList[indexPath.row]
        
        var cell = UITableViewCell()
        
        switch pokemonDetailsBlock {
        case .basic(let pokemon, _):
            if let basicsCell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.forPokemonBasicDetailsCell) as? PokemonBasicsTableViewCell {
                basicsCell.configureWith(viewModel: PokemonBasicsTableViewCell.ViewModel(withPokemon: pokemon))
                cell = basicsCell
            }
        case .types(let pokemon, _):
            if let typesCell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.forPokemonTypeCell) as? PokemonTypeTableViewCell {
                typesCell.configureWith(viewModel: PokemonTypeTableViewCell.ViewModel(withPokemon: pokemon))
                cell = typesCell
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch detailsBlockList[indexPath.row] {
        case .basic(_, let height):
            return CGFloat(height)
        case .types(_, let height):
            return CGFloat(height)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsBlockList.count
    }
}
