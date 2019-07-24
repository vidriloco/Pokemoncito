//
//  PanelBarIndicatorView.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/24/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class PanelBarIndicatorView : UIView {
    
    private var titleLabel = UILabel().with {
        $0.textAlignment = .justified
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.textColor = .white
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
    }.withoutAutoConstraints()
    
    private let stackView = UIStackView().withoutAutoConstraints().with {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.alignment = .fill
    }.withoutAutoConstraints()
    
    func configureWith(barsViewModels: [BarRepresentable], viewModel: ViewModel) {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        ])
        
        stackView.addArrangedSubview(titleLabel)
        titleLabel.text = viewModel.title
        
        stackView.spacing = viewModel.titleSpacing
        
        barsViewModels.forEach { powerBarModel in
            let barIndicatorForPokemonPower = BarIndicatorView().withoutAutoConstraints()
            barIndicatorForPokemonPower.configureWith(viewModel: powerBarModel, maximumMetricUnit: viewModel.maximumBarMetric)
            stackView.addArrangedSubview(barIndicatorForPokemonPower)
        }
        
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
    }
    
    struct ViewModel {
        let title: String
        let titleSpacing: CGFloat
        let maximumBarMetric: Float
    }
}
