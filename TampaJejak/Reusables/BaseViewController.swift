//
//  BaseViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import UIKit
import SnackBar_swift

class BaseViewController: UIViewController {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func loadView() {
        super.loadView()
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = UIColor.white
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        view.backgroundColor = .baseColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.dominantgreen]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.dominantgreen]
    }
    
    func showSnackbar(message: String) {
        MainSnackBar.make(in: self.view, message: message, duration: .lengthLong)
            .show()
    }


}
