//
//  ListViewCoordinator.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/5/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class ListViewCoordinator: Coordinator {
    private let presenter: UINavigationController
    
    private var apiProvider: PokemonAPIProvider

    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.apiProvider = PokemonAPIProvider()
    }
    
    func start() {
        let pokemonListViewController = PokemonListViewController(apiDevProvider: apiProvider)
        presenter.pushViewController(pokemonListViewController, animated: true)
        pokemonListViewController.pokemonDetailsViewDelegate = self
    }
}

extension ListViewCoordinator : PokemonDetailsCoordinatorDelegate {
    func presentDetailsViewForPokemon(pokemon: Pokemon) {
        let detailsViewController = PokemonDetailsViewController(apiDevProvider: apiProvider, pokemon: pokemon)
        presenter.pushViewController(detailsViewController, animated: true)
    }
    
    func dismissDetailsView() {
        presenter.popViewController(animated: true)
    }
    
    
}
