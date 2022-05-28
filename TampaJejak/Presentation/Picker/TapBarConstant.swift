//
//  TapBarConstant.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import UIKit

public enum TapBarConstant: String, CaseIterable {
    case Home,Activity,Account
    
    var viewController: UIViewController {
        switch self {
        case .Home:
            return HomeViewController(nibName: "HomeViewController", bundle: nil)
        case .Account:
            return AccountViewController(nibName: "AccountViewController", bundle: nil)
        case .Activity :
            return ActivityViewController(nibName: "ActivityViewController", bundle: nil)
        }
    }
    
    var title: String {
        return self.rawValue
    }
    
    //WIP
    var icon: UIImage? {
        switch self {
        case .Home:
            return UIImage(systemName: "house.fill")
        case .Activity:
            return UIImage(named: "activity")
        case .Account:
            return UIImage(systemName: "person.fill")
        }
    }
}
