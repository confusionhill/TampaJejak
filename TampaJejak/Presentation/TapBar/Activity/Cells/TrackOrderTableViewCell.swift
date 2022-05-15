//
//  TrackOrderTableViewCell.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit

protocol InfoButtonOutput: AnyObject {
    func didTapInfo()
}

class TrackOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    
    public static let identifier =  "TrackOrderTableViewCell"
    
    public weak var delegate: InfoButtonOutput?

    override func awakeFromNib() {
        super.awakeFromNib()
        infoButton.setRounded()
        infoButton.addTarget(self, action: #selector(self.didTapInfo), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func didTapInfo() {
        self.delegate?.didTapInfo()
    }
    
}
