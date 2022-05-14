//
//  UIViewExt.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import UIKit

extension UIView {
    func setRounded(
        size: CGSize,
        where parts: UIRectCorner
    ) {
       let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: parts, cornerRadii: size)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
