//
//  MainFoodCollectionViewCell.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit
import FirebaseStorage

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
        self.priceLabel.text = "Rp \(model.price.formattedWithSeparator)"
        self.titleLabel.text = model.name
        let ref = Storage.storage().reference(withPath: "foods/\(model.image)")
        ref.getData(maxSize: 4 * 1024 * 1024) {[weak self] data, error in
            guard let self = self else { return }
            if error != nil {
                print("error!!!")
                return
            }
            guard let data = data else { return }
            self.foodImage.image = UIImage(data: data)
        }
    }

}
