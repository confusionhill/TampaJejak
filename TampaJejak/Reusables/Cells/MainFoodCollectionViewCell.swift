//
//  MainFoodCollectionViewCell.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit

class MainFoodCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    
    public static let identifier = "MainFoodCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setContent(
        model: FoodModel
    ) {
        self.priceLabel.text = "Rp \(model.price)"
        self.titleLabel.text = model.name
    }

}
