//
//  BusyLoadingView.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/9/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import UIKit

class BusyLoadingView : UICollectionReusableView {
    
    @IBOutlet weak var messageLabel: UILabel?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
