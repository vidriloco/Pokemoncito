//
//  PowerTypeView.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/10/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class PowerTypeView: UIView {
    
    @IBOutlet weak var typeNameLabel: UILabel?
    @IBOutlet weak var imageView: UIImageView?
    
    struct ViewModel {
        let typeName : String
        
        var image: UIImage? {
            return UIImage(named: "\(typeName.capitalized)Icon")
        }
    }
    
    func configureWith(viewModel: ViewModel) {
        typeNameLabel?.text = viewModel.typeName
        typeNameLabel?.text = viewModel.typeName.uppercased()
        typeNameLabel?.textColor = .white
        typeNameLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        imageView?.image = viewModel.image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
