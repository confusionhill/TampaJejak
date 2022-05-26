//
//  CategoryTableViewCell.swift
//  TampaJejak
//
//  Created by Farhandika on 27/05/22.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    static let identifier = "CategoryTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.baseView.layer.cornerRadius = 15
        self.baseView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
