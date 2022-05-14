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
    
    override func loadView() {
        super.loadView()
        self.authPage.launchRef = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.launchInitScreen), userInfo: nil, repeats: false)
    }
    
    @objc func launchInitScreen() {
        let state: Bool = true
        if state {
            let navCon = UINavigationController(rootViewController: authPage)
            navCon.modalPresentationStyle = .fullScreen
            self.present(navCon, animated: true, completion: nil)
        } else {
            
        }
    }
}

extension FakeLaunchScreenViewController: FakeLaunchOuput {
    func didTapLogin() {
        self.dismiss(animated: true, completion: nil)
        
        //TODO: Change to Home VC
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func didTapLogout() {
        self.dismiss(animated: true, completion: nil)
        let navCon = UINavigationController(rootViewController: authPage)
        navCon.modalPresentationStyle = .fullScreen
        self.present(navCon, animated: true, completion: nil)
    }
}
