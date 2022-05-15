//
//  HeaderView.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit

class HeaderView: UIView {
    
    var title: UILabel = {
        let label = UILabel(
            frame: CGRect(
                x: 10, y: 0,
                width: 200, height: 20)
        )
        label.font =  UIFont.boldSystemFont(ofSize: 17.0)
        label.textColor = .dominantgreen
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(title)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addSubview(title)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let frame = title.frame
        let newFrame = CGRect(
            x: 17,
            y: 1, width: frame.width, height: self.bounds.height)
        title.frame = newFrame
    }

}
