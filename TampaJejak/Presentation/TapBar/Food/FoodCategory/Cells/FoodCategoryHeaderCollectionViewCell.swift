//
//  FoodCategoryHeaderCollectionViewCell.swift
//  TampaJejak
//
//  Created by Farhandika on 16/05/22.
//

import UIKit

protocol HeaderDelegate: AnyObject {
    func didTapSearch()
}

class FoodCategoryHeaderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    
    public static let identifier = "FoodCategoryHeaderCollectionViewCell"
    
    weak var delegate: HeaderDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupSearchButton()
    }
    
    private func setupSearchButton() {
        self.searchButton.contentHorizontalAlignment = .left
        self.searchButton.setRounded(cornerRadius: 11)
        let image1Attachment = NSTextAttachment()
        let fullString = NSMutableAttributedString()
        image1Attachment.image = UIImage(systemName: "magnifyingglass")?.withTintColor(.opaqueSeparator, renderingMode: .alwaysOriginal)

        // wrap the attachment in its own attributed string so we can append it
        let image1String = NSAttributedString(attachment: image1Attachment)

        // add the NSTextAttachment wrapper to our full string, then add some more text.
        fullString.append(image1String)
        fullString.append(NSAttributedString(string: " Want to explore new dishes?"))
        self.searchButton.setAttributedTitle(fullString, for: .normal)
    }
    @IBAction func didTapSearch(_ sender: UIButton) {
        self.delegate?.didTapSearch()
    }
    
    func setTitle(title: String) {
        self.categoryLabel.text = title
    }

}
