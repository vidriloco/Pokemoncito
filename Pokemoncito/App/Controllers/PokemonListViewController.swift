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
    private var imageDataGetter = ImageDataGetter(qualityOfService: .userInteractive)
    
    private let reuseIdentifier = "PokemonCell"
    private let busyFooterReuseIdentifier = "PokemonFooterBusy"
    private let pagingEndedFooterReuseIdentifier = "PagingEndFooter"
    
    private let cellSize = CGSize(width: 90, height: 90)
    private let numberOfSections = 1
    
    private var listOffset = 0
    private let offsetIncrement = 20
    
    private var paginationEnded = false
    
    private let backgroundView = BackgroundListView().with {
        $0.setupViewsAndConstraints()
        $0.updateWith(status: .loading("Loading", "Please wait ..."))
    }
    
    private var pokemons = [Pokemon]()

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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetCollectionList))
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(UINib(nibName: "BusyLoadingView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: busyFooterReuseIdentifier)
        collectionView.register(UINib(nibName: "PagingEndView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: pagingEndedFooterReuseIdentifier)
        collectionView.backgroundColor = .black
        collectionView.backgroundView = backgroundView
        
        fetchPokemons()
    }
}

// MARK - Handling of collection items management

extension PokemonListViewController {
    
    @objc private func resetCollectionList() {
        listOffset = 0
        paginationEnded = false
        fetchPokemons()
    }
    
    private func fetchPokemons() {
        if paginationEnded {
            return
        }
        
        updateBackgroundViewMessageForClearedCollection()
        
        apiDevProvider.fetchPokemons(offset: listOffset, completion: { [weak self] pokemons in
            
            guard let self = self else { return }
            
            if pokemons.isEmpty {
                self.paginationEnded = true
                return
            }
            
            self.pokemons.append(contentsOf: pokemons)
            DispatchQueue.main.async {
                
                if self.pokemons.isEmpty {
                    self.backgroundView.updateWith(status: .empty("Ooops!", "There are no pokemons to display", "Try again by tapping the reload button"))
                } else {
                    self.collectionView.reloadData()
                    self.backgroundView.isHidden = true
                }
            }
        }) {
            // TODO: Handle error case
            self.backgroundView.updateWith(status: .error("Oh no :/", "There was a problem fetching the pokemons"))
        }
    }
    
    private func updateBackgroundViewMessageForClearedCollection() {
        if listOffset != 0 {
            return
        }
        
        backgroundView.isHidden = false
        backgroundView.updateWith(status: .loading("Loading", "Please wait ..."))
        
        pokemons = []
        collectionView.reloadData()
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
            
            if let url = urlForPokemonAt(indexPath: indexPath) {
                if let imageData = pokemons[indexPath.item].mainImage {
                    imageCell.configureWith(image: UIImage(data: imageData))
                } else {
                    imageDataGetter.download(fromURL: url) { [weak imageCell, weak self] imageData in
                        guard let self = self, let imageCell = imageCell else { return }
                        
                        DispatchQueue.main.async {
                            imageCell.configureWith(image: UIImage(data: imageData))
                            self.pokemons[indexPath.item].mainImage = imageData
                        }
                    }
                }
            } else {
                imageCell.configureWith(image: UIImage(named: "Incognito"))
            }
            
        }
        
        return dequeuedCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.item]
        pokemonDetailsViewDelegate?.presentDetailsViewForPokemon(pokemon: pokemon)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == pokemons.count-1 {
            listOffset += offsetIncrement
            fetchPokemons()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if (kind == UICollectionView.elementKindSectionFooter) {
            
            var reusableFooterView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: busyFooterReuseIdentifier, for: indexPath)
            
            if paginationEnded {
                reusableFooterView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: pagingEndedFooterReuseIdentifier, for: indexPath)
            }
            
            reusableFooterView.isHidden = !backgroundView.isHidden
            return reusableFooterView
        }
        fatalError()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 80)
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
    
    private func urlForPokemonAt(indexPath: IndexPath) -> String? {
        return pokemons[indexPath.item].sprites["front_default"]
    }
    
}
