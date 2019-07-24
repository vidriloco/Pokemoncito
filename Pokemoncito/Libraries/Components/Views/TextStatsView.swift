//
//  TextStatsView.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/8/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class TextStatsView : UIView {
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    
    struct ViewModel {
        let titleValue : String
        let subtitleValue : String
    }
    
    func configureWith(viewModel: ViewModel) {
        titleLabel?.text = viewModel.titleValue
        subtitleLabel?.text = viewModel.subtitleValue.uppercased()
        titleLabel?.textColor = .white
        subtitleLabel?.textColor = .white
        subtitleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
