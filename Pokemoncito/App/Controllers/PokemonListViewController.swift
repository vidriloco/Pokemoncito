//
//  PokemonListViewController.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/5/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class PokemonListViewController: UICollectionViewController {
    
    var pokemonDetailsViewDelegate : PokemonDetailsCoordinatorDelegate?
    
    private let apiDevProvider: PokemonAPIProvider
    private let imageDataGetter: ImageDataGetter
    
    private let reuseIdentifier = "PokemonCell"
    private let cellSize = CGSize(width: 90, height: 90)
    private let numberOfSections = 1
    
    private let backgroundView = BackgroundListView().with {
        $0.setupViewsAndConstraints()
        $0.updateWith(status: .loading("Loading", "Please wait ..."))
    }
    
    private var pokemons = [Pokemon]()

    init(apiDevProvider: PokemonAPIProvider) {
        self.apiDevProvider = apiDevProvider
        self.imageDataGetter = ImageDataGetter(qualityOfService: .userInteractive)
        
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updatePokemonList))
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .black
        collectionView.backgroundView = backgroundView
        
        updatePokemonList()
    }
    
    @objc private func updatePokemonList() {
        backgroundView.isHidden = false
        print("Updating")
        apiDevProvider.fetchPokemons(completion: { [weak self] pokemons in
            self?.pokemons = pokemons
            
            DispatchQueue.main.async {
                
                if self?.pokemons.isEmpty ?? false {
                    self?.backgroundView.updateWith(status: .empty("Ooops!", "There are no pokemons to display", "Try again by tapping the reload button"))
                } else {
                    self?.collectionView.reloadData()
                    self?.backgroundView.isHidden = true
                }
            }
        }) {
            // TODO: Handle error case
            print("Error fetching pokemons")
        }
    }
}

// MARK - Handling of collection views

extension PokemonListViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequeuedCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if let imageCell = dequeuedCell as? ImageViewCell {
            imageCell.configureWith(image: .none)
            
            let url = urlForPokemonAt(indexPath: indexPath)
            
            imageDataGetter.download(fromURL: url) { [weak imageCell] imageData in
                imageCell?.configureWith(image: UIImage(data: imageData))
            }
        }
        
        return dequeuedCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.item]
        print(pokemon.name)
        pokemonDetailsViewDelegate?.presentDetailsViewForPokemon(pokemon: pokemon)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didEndDisplaying cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        
        let url = urlForPokemonAt(indexPath: indexPath)
        imageDataGetter.cancelDownload(fromURL: url)
    }
}

// MARK - View delegate layout

extension PokemonListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    }
    
}

// MARK - Helper functions

extension PokemonListViewController {
    
    private func urlForPokemonAt(indexPath: IndexPath) -> String {
        return pokemons[indexPath.item].sprites["front_default"] ?? ""
    }
    
    private func triggerReload(at indexPath: IndexPath) {
        DispatchQueue.main.async {
            if self.collectionView.indexPathsForVisibleItems.contains(indexPath) {
                self.collectionView.reloadItems(at: [indexPath])
            }
        }
    }
    
}
