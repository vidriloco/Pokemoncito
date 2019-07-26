//
//  UIStackView+Extensions.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/26/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
