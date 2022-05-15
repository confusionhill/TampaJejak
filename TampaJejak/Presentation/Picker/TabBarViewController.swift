//
//  TabBarViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import UIKit

protocol TabBarDelegate: AnyObject {
    func logoutTapped()
}

class TabBarViewController: UITabBarController {
    weak var launchRef: FakeLaunchOuput?
    var vcs: [UIViewController] = []
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    init(launchRef: FakeLaunchOuput?) {
        super.init(nibName: nil, bundle: nil)
        self.launchRef = launchRef
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTapBar()
    }
    
    private func setupTapBar() {
        for item in TapBarConstant.allCases {
            var vc = item.viewController
            if vc is AccountViewController {
                let newVC = vc as! AccountViewController
                newVC.tabBarRef = self
                vc = newVC
            }
            vc.tabBarItem = UITabBarItem(title: item.title, image: UIImage(systemName: "house.fill"), tag: item.hashValue)
            let navCon = UINavigationController(rootViewController: vc)
            vcs.append(navCon)
        }
        
        self.viewControllers = self.vcs
    }

}

extension TabBarViewController: TabBarDelegate {
    func logoutTapped() {
        launchRef?.didTapLogout()
    }
}
