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
    
    private var devProvider: PokemonAPIProvider

    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.devProvider = PokemonAPIProvider()
    }
    
    func start() {
        let pokemonListViewController = PokemonListViewController(apiDevProvider: devProvider)
        presenter.pushViewController(pokemonListViewController, animated: true)

    }
}
