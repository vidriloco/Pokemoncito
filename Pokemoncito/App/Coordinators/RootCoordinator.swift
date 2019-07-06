//
//  RootCoordinator.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/5/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class RootCoordinator: Coordinator {
    
    let window: UIWindow
    let rootViewController: UINavigationController
    
    let listViewCoordinator: ListViewCoordinator
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        
        listViewCoordinator = ListViewCoordinator(presenter: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        listViewCoordinator.start()
        window.makeKeyAndVisible()
    }
}
