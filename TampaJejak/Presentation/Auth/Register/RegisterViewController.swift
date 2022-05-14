//
//  RegisterViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import UIKit

class RegisterViewController: BaseViewController {
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var rePasswordField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    weak var launchRef: FakeLaunchOuput?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create your account"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        registerButton.setRounded()
    }

    @IBAction func didTapRegister(_ sender: UIButton) {
        self.launchRef?.didTapLogin()
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
    }
}
