//
//  UITextfieldExt.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import UIKit

extension UITextField {
    func setAuthInputConfig() {
        self.backgroundColor = .secondarySystemBackground
               // nambah corner radius agar bulet
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
    
    func setDefaultInput() {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 23, height: self.frame.height))
        self.leftViewMode = .always
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 23, height: self.frame.height))
        self.rightViewMode = .always
        self.contentVerticalAlignment = .center
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
    }
}
