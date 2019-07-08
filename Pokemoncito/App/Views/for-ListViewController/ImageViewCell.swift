//
//  ImageViewCell.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/6/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class ImageViewCell: UICollectionViewCell {
    
    let imageView = UIImageView().withoutAutoConstraints()
    let loadingIndicator = UIActivityIndicatorView().withoutAutoConstraints()
    
    func configureWith(image: UIImage?, animated: Bool = false) {
        DispatchQueue.main.async { [weak self] in
            self?.setupViewsAndConstraints()
            self?.updateViews(with: image)
        }
    }
    
    private func updateViews(with image: UIImage?) {
        if let imageAvailable = image {
            imageView.image = imageAvailable
            imageView.isHidden = false
            loadingIndicator.isHidden = true
            loadingIndicator.stopAnimating()
        } else {
            imageView.isHidden = true
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
        }
    }
    
    private func setupViewsAndConstraints() {
        addSubview(imageView)
        addSubview(loadingIndicator)
        
        imageView.backgroundColor = .clear
        imageView.layer.backgroundColor = UIColor.white.cgColor.copy(alpha: 0.1)
        imageView.layer.cornerRadius = 10
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        let verticalImageConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[imageView]|", metrics: nil, views: ["imageView": imageView])
        let horizontalImageConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[imageView]|", metrics: nil, views: ["imageView": imageView])
        
        var constraints = [
            loadingIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        constraints.append(contentsOf: verticalImageConstraint + horizontalImageConstraint)
        NSLayoutConstraint.activate(constraints)
    }
    
    override func prepareForReuse() {
        DispatchQueue.main.async { [weak self] in
            self?.updateViews(with: .none)
        }
    }
}
