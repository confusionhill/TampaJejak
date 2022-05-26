//
//  OrderTableViewCell.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit
import FirebaseStorage

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
        self.totalPriceLabel.text = "Rp \((foodModel.quantity * foodModel.price).formattedWithSeparator)"
        
        let ref = Storage.storage().reference(withPath: "foods/\(foodModel.image)")
        ref.getData(maxSize: 4 * 1024 * 1024) {[weak self] data, error in
            guard let self = self else { return }
            if error != nil {
                print("error!!! \(error!.localizedDescription)")
                return
            }
            guard let data = data else { return }
            self.foodImage.image = UIImage(data: data)
        }
    }
}
