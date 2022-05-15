//
//  OrderTableViewCell.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    public static let identifier = "OrderTableViewCell"
    
    @IBOutlet weak var foodImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        foodImage.layer.cornerRadius = 20
        foodImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
