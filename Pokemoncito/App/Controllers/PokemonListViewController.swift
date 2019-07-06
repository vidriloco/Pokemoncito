//
//  PokemonListViewController.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/5/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class PokemonListViewController: UICollectionViewController {
    
    private let apiDevProvider: PokemonAPIProvider
    init(apiDevProvider: PokemonAPIProvider) {
        self.apiDevProvider = apiDevProvider
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.estimatedItemSize = cellSize
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Pokemons"

        apiDevProvider.fetchPokemons(completion: { pokemons in
            self.pokemons = pokemons
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }) {
            print("Error fetching pokemons")
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .black
    }
}
