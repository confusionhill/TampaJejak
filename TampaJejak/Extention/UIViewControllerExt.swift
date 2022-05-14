//
//  UIViewControllerExt.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import UIKit

extension UIViewController {
    open override func awakeAfter(using coder: NSCoder) -> Any? {
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .dominantgreen
        return super.awakeAfter(using: coder)
    }
}
