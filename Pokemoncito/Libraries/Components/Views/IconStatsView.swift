//
//  IconStatsView.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/10/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class IconStatsView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var imageView: UIImageView?
    
    struct ViewModel {
        let title : String
        
        var image: UIImage? {
            return UIImage(named: "\(title.capitalized)Icon")
        }
    }
    
    func configureWith(viewModel: ViewModel) {
        titleLabel?.text = viewModel.title
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        imageView?.image = viewModel.image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
