//
//  CarouselCollectionViewCell.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit
import FirebaseStorage

final class CarouselCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var gradientBG: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    public static let identifier = "CarouselCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public func setContent(model: FoodModel){
        self.priceLabel.text = "Rp \(model.price.formattedWithSeparator)"
        self.nameLabel.text = model.name
        let ref = Storage.storage().reference(withPath: "foods/\(model.image)")
        ref.getData(maxSize: 4 * 1024 * 1024) {[weak self] data, error in
            guard let self = self else { return }
            if error != nil {
                print("error!!!")
                return
            }
            guard let data = data else { return }
            self.foodImageView.image = UIImage(data: data)
        }
    }
    

}
