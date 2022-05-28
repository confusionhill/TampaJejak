//
//  HomeHeaderTableViewCell.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit

protocol HomeHeaderDelegate: AnyObject {
    func didTapSearch()
}

class HomeHeaderTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var searchButton: UIButton!
    
    public static let identifier = "HomeHeaderTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
    }
    
    weak var delegate: HomeHeaderDelegate?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func didTapSearch(_ sender: UIButton) {
        self.delegate?.didTapSearch()
    }
    
    private func setupButton() {
        self.searchButton.contentHorizontalAlignment = .left
        self.searchButton.setRounded(cornerRadius: 11)
        
        let fullString = NSMutableAttributedString()

        // create our NSTextAttachment
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = UIImage(systemName: "magnifyingglass")?.withTintColor(.opaqueSeparator, renderingMode: .alwaysOriginal)

        // wrap the attachment in its own attributed string so we can append it
        let image1String = NSAttributedString(attachment: image1Attachment)

        // add the NSTextAttachment wrapper to our full string, then add some more text.
        fullString.append(image1String)
        fullString.append(NSAttributedString(string: " Want to explore new dishes?"))
        self.searchButton.setAttributedTitle(fullString, for: .normal)
    }
    
}
