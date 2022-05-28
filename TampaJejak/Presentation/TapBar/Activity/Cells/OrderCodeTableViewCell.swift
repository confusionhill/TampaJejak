//
//  OrderCodeTableViewCell.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit

class OrderCodeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderCodeLabel: UILabel!
    public static let identifier = "OrderCodeTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setupContent(code: String){
        let codes = code.split(separator: "-")
        self.orderCodeLabel.text = String(codes[0])
    }
    
}
