//
//  TapBarConstant.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import UIKit

public enum TapBarConstant: String, CaseIterable {
    case Home,Account
    
    var viewController: UIViewController {
        switch self {
        case .Home:
            return HomeViewController(nibName: "HomeViewController", bundle: nil)
        case .Account:
            return AccountViewController(nibName: "AccountViewController", bundle: nil)
        }
    }
    
    var title: String {
        return self.rawValue
    }
    
    //WIP
    var icon: UIImage? {
        return nil
    }
}
