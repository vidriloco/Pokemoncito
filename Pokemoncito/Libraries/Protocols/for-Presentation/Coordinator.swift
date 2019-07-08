//
//  Coordinator.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/5/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import Foundation

protocol Coordinator {
    func start()
}

protocol PokemonDetailsCoordinatorDelegate {
    func presentDetailsViewForPokemon(pokemon: Pokemon)
    func dismissDetailsView()
}
