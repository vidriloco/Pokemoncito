//
//  StatsView.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/8/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class StatsView : UIView {
    
    @IBOutlet weak var numberLabel: UILabel?
    @IBOutlet weak var unitsLabel: UILabel?
    
    struct ViewModel {
        let number : String
        let units : String
    }
    
    func configureWith(viewModel: ViewModel) {
        numberLabel?.text = viewModel.number
        unitsLabel?.text = viewModel.units.uppercased()
        numberLabel?.textColor = .white
        unitsLabel?.textColor = .white
        unitsLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
