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
}
