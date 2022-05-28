//
//  UIButtonExt.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import UIKit

extension UIButton {
    public enum buttonType {
        case primary, secondary
    }
    
    public func setRounded(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    public func setRounded() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    public func setCircular() {
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
}
