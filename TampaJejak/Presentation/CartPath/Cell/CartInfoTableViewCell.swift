//
//  CartInfoTableViewCell.swift
//  TampaJejak
//
//  Created by Farhandika on 17/05/22.
//

import FirebaseStorage
import UIKit

protocol CartInfoCellDelegate: AnyObject {
    func didTapDelete(index: IndexPath)
    func didChangeQuantity(newVal: Int, index: IndexPath)
}

class CartInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var trashImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!

    
    static let identifier = "CartInfoTableViewCell"
    
    var cellIndexPath: IndexPath = IndexPath()
    
    var count: Int = 0
    private(set) var initVal = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapTrash))
        trashImageView.isUserInteractionEnabled = true
        trashImageView.addGestureRecognizer(tapGestureRecognizer)
        foodImage.layer.cornerRadius = 20
        foodImage.layer.masksToBounds = true
        stackView.layer.cornerRadius = 5
        stackView.layer.masksToBounds = true
    }
    
    weak var delegate: CartInfoCellDelegate?
    
    func setupCell(delegate: CartInfoCellDelegate, index indexPath: IndexPath) {
        self.delegate = delegate
        self.cellIndexPath = indexPath
    }
    
    @IBAction func didTapPlus(){
        if count < initVal {
            self.count += 1
        }
        self.quantityLabel.text = String(self.count)
        self.delegate?.didChangeQuantity(newVal: self.count, index: self.cellIndexPath)
    }
    @IBAction func didTapMinus() {
        if count > 1 {
            count -= 1
        }
        self.quantityLabel.text = String(self.count)
        self.delegate?.didChangeQuantity(newVal: self.count, index: self.cellIndexPath)
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
    
    public func setContent(foodModel: FoodModel) {
        self.titleLabel.text = foodModel.name
        self.quantityLabel.text = "\(foodModel.quantity)"
        self.count = foodModel.quantity
        self.initVal = count
        let ref = Storage.storage().reference(withPath: "foods/\(foodModel.image)")
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
