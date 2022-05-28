//
//  TrackOrderTableViewCell.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit

protocol InfoButtonOutput: AnyObject {
    func didTapInfo(indexPath: IndexPath)
}

class TrackOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    
    public static let identifier =  "TrackOrderTableViewCell"
    
    public weak var delegate: InfoButtonOutput?
    var indexPath: IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()
        infoButton.setRounded()
        infoButton.addTarget(self, action: #selector(self.didTapInfo), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setContent(price: Int) {
        self.priceLabel.text = "Rp \(price.formattedWithSeparator)"
    }
    
    public func hideInfoButton(state: Bool) {
        self.infoButton.isHidden = state
    }
    
    @objc func didTapInfo() {
        self.delegate?.didTapInfo(indexPath: self.indexPath!)
    }
    
}
