//
//  TestSinkViewController.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/24/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class TestSinkViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let indicatorView = PanelBarIndicatorView().withoutAutoConstraints()
        view.addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            indicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: indicatorView.trailingAnchor, constant: 20),
            indicatorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            view.bottomAnchor.constraint(equalTo: indicatorView.bottomAnchor)
        ])
        
        indicatorView.configureWith(barsViewModels: [RedBar(), BlueBar()], viewModel: PanelBarIndicatorView.ViewModel(title: "Pokemon's EVs".uppercased(), titleSpacing: 20, maximumBarMetric: 252))
    }
}

struct RedBar: BarRepresentable {
    func title() -> String {
        return "Strength"
    }
    
    func color() -> UIColor {
        return .red
    }
    
    func value() -> Float {
        return 200
    }
}

struct BlueBar: BarRepresentable {
    func title() -> String {
        return "Mindfullness"
    }
    
    func color() -> UIColor {
        return .blue
    }
    
    func value() -> Float {
        return 60
    }
}
