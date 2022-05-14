//
//  SignInViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import UIKit

class SignInViewController: UIViewController {
    let button: UIButton = UIButton(frame: CGRect(
        x: 30, y: 100,
        width: 100, height: 30))
    weak var launchRef: FakeLaunchOuput?
    
    override func loadView() {
        super.loadView()
        button.setTitle("testing", for: .normal)
        button.backgroundColor = .white
        self.view.addSubview(button)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        view.backgroundColor = .green
    }
    
    @objc func didTapLogin() {
        self.launchRef?.didTapLogin()
    }
}
