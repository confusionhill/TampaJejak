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
    
    public func setRounded() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
}
