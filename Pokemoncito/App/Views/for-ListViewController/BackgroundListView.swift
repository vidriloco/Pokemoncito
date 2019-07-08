//
//  BackgroundListView.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/7/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class BackgroundListView : UIView {
    
    private let standardMargin : CGFloat = 30
    
    private let stackView = UIStackView().withoutAutoConstraints().with {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.alignment = .center
        $0.spacing = 10
    }
    
    private let loadingIndicator = UIActivityIndicatorView().withoutAutoConstraints().with {
        $0.style = UIActivityIndicatorView.Style.whiteLarge
    }
    
    private let imageView = UIImageView().withoutAutoConstraints().with {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "ErrorIcon")
    }
    
    private var titleLabel = UILabel().with {
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 30)
        $0.textColor = .white
        $0.numberOfLines = 1
    }.withoutAutoConstraints()
    
    private var subtitleLabel = UILabel().with {
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .white
        $0.numberOfLines = 0
    }.withoutAutoConstraints()
    
    private var instructionsLabel = UILabel().with {
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .white
        $0.numberOfLines = 1
    }.withoutAutoConstraints()
    
    enum Status {
        case loading(String, String)
        case empty(String, String, String)
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewsAndConstraints() {
        
        addSubview(loadingIndicator)
        addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(instructionsLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.topAnchor.constraint(equalTo: loadingIndicator.bottomAnchor, constant: standardMargin),
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: standardMargin)
        ])
        
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        subtitleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        instructionsLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }

    func updateWith(status: Status) {
        switch status {
        case .empty(let title, let subtitle, let instructions):
            
            imageView.isHidden = false

            loadingIndicator.isHidden = true
            loadingIndicator.stopAnimating()

            titleLabel.text = title
            subtitleLabel.text = subtitle
            instructionsLabel.text = instructions
        case .loading(let title, let subtitle):
            
            imageView.isHidden = true
            
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
            
            titleLabel.text = title
            subtitleLabel.text = subtitle
            instructionsLabel.text = nil
        }
    }
    
}
