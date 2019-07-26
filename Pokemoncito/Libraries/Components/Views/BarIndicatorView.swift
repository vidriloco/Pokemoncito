//
//  BarIndicatorView.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/24/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class BarIndicatorView : UIView {
    
    struct VisualDimensions {
        static let barHeight : CGFloat = 40
        static let cornerRadius : CGFloat  = 20
        static let gapBetweenTitleAndBar : CGFloat = 10
    }
    
    private var titleLabel = UILabel().with {
        $0.textAlignment = .left
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .white
        $0.numberOfLines = 1
    }.withoutAutoConstraints()
    
    private var numericLabel = UILabel().with {
        $0.textAlignment = .left
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.textColor = .white
        $0.numberOfLines = 1
        $0.textColor = UIColor.white.withAlphaComponent(0.5)
    }.withoutAutoConstraints()
    
    private let backgroundView = UIView().with {
        $0.layer.backgroundColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        $0.layer.cornerRadius = VisualDimensions.cornerRadius
    }.withoutAutoConstraints()
    
    private let barView = UIView().with {
        $0.layer.cornerRadius = VisualDimensions.cornerRadius
    }.withoutAutoConstraints()
    
    func configureWith(viewModel: BarRepresentable, maximumMetricUnit: Float, animated: Bool = true) {
        numericLabel.attributedText = attributedStringForStatsWith(numericValue: Int(viewModel.value()), maximumNumericValue: Int(maximumMetricUnit))
        
        titleLabel.text = viewModel.title()
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        addSubview(titleLabel)
        
        addSubview(backgroundView)
        addSubview(numericLabel)
        
        barView.layer.backgroundColor = viewModel.color().cgColor
        addSubview(barView)
        
        let ratio = CGFloat(viewModel.value()*1)
        let barWidth : CGFloat = ratio/CGFloat(maximumMetricUnit)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: VisualDimensions.gapBetweenTitleAndBar),
            backgroundView.heightAnchor.constraint(equalToConstant: VisualDimensions.barHeight),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            barView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            barView.heightAnchor.constraint(equalTo: backgroundView.heightAnchor),
            barView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            barView.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: barWidth),
            backgroundView.trailingAnchor.constraint(equalTo: numericLabel.trailingAnchor, constant: 20),
            numericLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
        
        setNeedsLayout()
        layoutIfNeeded()

        if animated {
            barView.transform = CGAffineTransform(translationX: -frame.width, y: 0)
            barView.alpha = 0
            UIView.animate(withDuration: 0.75) {
                self.barView.transform = .identity
                self.barView.alpha = 1
            }
        }
    }
    
    private func attributedStringForStatsWith(numericValue: Int, maximumNumericValue: Int) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(numericValue)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
        
        attributedString.append(NSMutableAttributedString(string: " / \(maximumNumericValue)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.8)]))
        
        return attributedString
    }
    
    struct ViewModel : BarRepresentable {
        func title() -> String {
            return titleValue
        }
        
        func color() -> UIColor {
            return colorValue
        }
        
        func value() -> Float {
            return numericValue
        }
        
        let colorValue: UIColor
        let titleValue: String
        let numericValue: Float
    }
}

protocol BarRepresentable {
    func title() -> String
    func color() -> UIColor
    func value() -> Float
}
