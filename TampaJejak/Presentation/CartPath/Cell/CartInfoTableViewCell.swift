//
//  CartInfoTableViewCell.swift
//  TampaJejak
//
//  Created by Farhandika on 17/05/22.
//

import UIKit

protocol CartInfoCellDelegate: AnyObject {
    func didTapDelete(index: IndexPath)
    
}

class CartInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trashImageView: UIImageView!
    
    static let identifier = "CartInfoTableViewCell"
    
    var cellIndexPath: IndexPath = IndexPath()

    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapTrash))
        trashImageView.isUserInteractionEnabled = true
        trashImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    weak var delegate: CartInfoCellDelegate?
    
    func setupCell(delegate: CartInfoCellDelegate, index indexPath: IndexPath) {
        self.delegate = delegate
        self.cellIndexPath = indexPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 10))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func didTapTrash() {
        self.delegate?.didTapDelete(index: self.cellIndexPath)
    }
    
}
