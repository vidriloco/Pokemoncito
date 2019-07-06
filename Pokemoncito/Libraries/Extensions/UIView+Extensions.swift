//
//  UIView+Extensions.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/6/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

extension UIView {
    
    func withoutAutoConstraints() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
}
