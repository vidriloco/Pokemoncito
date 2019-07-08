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
    private let cellReuseIdentifier = "PokemonDetailViewCell"

    enum PokemonDetailBlock {
        case basic(Pokemon, Float)
        case stats(Int, Float, Float)
        case speciesInfo(String, [String])
    }
    
    struct BlockDetailsViewCell {
        static let basicHeight : Float = 200
    }
    
    init(apiDevProvider: PokemonAPIProvider, pokemon: Pokemon) {
        super.init(nibName: nil, bundle: nil)
        
        detailsBlockList.append(.basic(pokemon, BlockDetailsViewCell.basicHeight))
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
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        if cell == nil {
            switch pokemonDetailsBlock {
                case .basic(let pokemon, _):
                    let basicsCell = PokemonBasicsTableViewCell().withoutAutoConstraints()
                    basicsCell.configureWith(viewModel: PokemonBasicsTableViewCell.ViewModel(withPokemon: pokemon))
                    cell = basicsCell
                default:
                    cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellReuseIdentifier)
            }
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch detailsBlockList[indexPath.row] {
        case .basic(_, let height):
            return CGFloat(height)
        default:
            return 0
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsBlockList.count
    }
}
