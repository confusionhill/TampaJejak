//
//  UIColorExt.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import UIKit

extension UIColor {
    
    static var dominantgreen: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(named: "dominantgreen") ?? UIColor(red: 0.00, green: 0.33, blue: 0.33, alpha: 1.00)
        } else {
            return UIColor(red: 0.00, green: 0.33, blue: 0.33, alpha: 1.00)
        }
    }
    
    static var primarygreen: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(named: "primarygreen") ?? UIColor(red: 0.02, green: 0.60, blue: 0.56, alpha: 1.00)
        } else {
            return UIColor(red: 0.02, green: 0.60, blue: 0.56, alpha: 1.00)
        }
    }
    
    static var secondarygreen: UIColor {
        return UIColor(named: "secondarygreen") ?? UIColor(red: 0.63, green: 0.89, blue: 0.85, alpha: 1.00)
    }
    
    static var alternatejejak: UIColor {
        return UIColor(red: 0.91, green: 0.94, blue: 0.48, alpha: 1.00)
    }
    
    static var baseColor: UIColor {
        return UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
    }
}
