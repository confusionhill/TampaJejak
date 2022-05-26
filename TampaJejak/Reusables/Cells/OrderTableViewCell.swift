//
//  OrderTableViewCell.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    public static let identifier = "OrderTableViewCell"
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        foodImage.layer.cornerRadius = 20
        foodImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setupContent(foodModel: FoodModel) {
        self.quantityLabel.text = "\(foodModel.quantity)x"
        self.titleLabel.text = foodModel.name
        self.totalPriceLabel.text = "Rp \(foodModel.quantity * foodModel.price)"
    }
}
