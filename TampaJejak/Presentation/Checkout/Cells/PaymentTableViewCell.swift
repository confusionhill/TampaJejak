//
//  PaymentTableViewCell.swift
//  TampaJejak
//
//  Created by Farhandika on 26/05/22.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var arrowImage: UIImageView!
    
    static let identifier = "PaymentTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    public func setContent(paymentType: PaymentSystem){
        self.subLabel.text = paymentType.sub
        self.titleLabel.text = paymentType.rawValue
        self.arrowImage.isHidden = true
    }
    
    public func setContentForPickup(pickupType: PickupType) {
        self.subLabel.text = ""
        self.titleLabel.text = pickupType.rawValue
        self.arrowImage.isHidden = true
        self.iconImage.image = UIImage(systemName: "bag.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
    }
    
}
