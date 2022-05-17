//
//  FakeLaunchScreenViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import UIKit

protocol FakeLaunchOuput: AnyObject {
    func didTapLogin()
    func didTapLogout()
}

class FakeLaunchScreenViewController: UIViewController {
    private var authPage: SignInViewController = {
        let vc = SignInViewController(nibName: "SignInViewController", bundle: nil)
        return vc
    }()
    
    private let viewModel = LaunchScreenViewModel()
    
    private var tabBar: TabBarViewController = {
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        return vc
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "FakeLaunchScreenViewController", bundle: nil)
        viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel.output = self
    }
    
    override func loadView() {
        super.loadView()
        self.authPage.launchRef = self
        self.tabBar.launchRef = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    @objc func launchInitScreen() {
        if viewModel.isLogin {
            let navCon = UINavigationController(rootViewController: authPage)
            navCon.modalPresentationStyle = .fullScreen
            self.present(navCon, animated: true, completion: nil)
        } else {
            self.present(self.tabBar, animated: true, completion: nil)
        }
    }
}

extension FakeLaunchScreenViewController: FakeLaunchOuput {
    func didTapLogin() {
        self.dismiss(animated: true, completion: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.present(self.tabBar, animated: true, completion: nil)
        }
    }
    
    func didTapLogout() {
        self.dismiss(animated: true, completion: nil)
        let navCon = UINavigationController(rootViewController: authPage)
        navCon.modalPresentationStyle = .fullScreen
        self.present(navCon, animated: true, completion: nil)
    }
}

extension FakeLaunchScreenViewController: LaunchScreenViewModelOutput {
    func navigateInitialViewController() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.launchInitScreen), userInfo: nil, repeats: false)
    }
}
