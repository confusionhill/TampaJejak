//
//  BaseCollectionView.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit

class BaseCollectionView: UICollectionView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .baseColor
    }

}
