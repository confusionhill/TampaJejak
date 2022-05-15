//
//  SignInViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var drawerView: UIView!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    weak var launchRef: FakeLaunchOuput?
    var viewModel: SignInViewModel!
    
    lazy var eyeButton: UIButton = {
        let button = UIButton(frame: CGRect(
            x: 0, y: 0,
            width: 23, height: 23))
        button.setTitle(" ", for: .normal)
        button.setImage(UIImage(systemName: "eye.slash.fill")?.withTintColor(.secondaryLabel,renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        SignInViewModel.setup(vc: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupDrawer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        SignInViewModel.setup(vc: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func loadView() {
        super.loadView()
        self.viewModel.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.viewDidLoad()
    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        self.launchRef?.didTapLogin()
    }
    
    private func setupRegisterLabel() {
        let attributedText = NSMutableAttributedString(string: "Didn’t have an account?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        attributedText.append(NSAttributedString(string: " Sign Up!",attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.primarygreen]))
        registerLabel.attributedText = attributedText
        registerLabel.numberOfLines = 1
        registerLabel.textAlignment = .center
        
        self.registerLabel.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(self.signUpTapped))
               tapgesture.numberOfTapsRequired = 1
               self.registerLabel.addGestureRecognizer(tapgesture)
    }
    
    private func setupPasswordField() {
        eyeButton.addTarget(self, action: #selector(self.eyeButtonTapped(_:)), for: .touchUpInside)
        self.passwordField.isSecureTextEntry = true
        self.passwordField.rightViewMode = .always
        self.passwordField.rightView = eyeButton
        passwordField.backgroundColor = .secondarySystemBackground
        passwordField.layer.cornerRadius = 20
        passwordField.layer.masksToBounds = true
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 23, height: userNameField.frame.height))
        passwordField.leftViewMode = .always
        passwordField.contentVerticalAlignment = .center
        passwordField.delegate = self
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor.clear.cgColor
    }
    
    private func setupUsernameField() {
        userNameField.backgroundColor = .secondarySystemBackground
               // nambah corner radius agar bulet
        userNameField.layer.cornerRadius = 20
        userNameField.layer.masksToBounds = true
               // nambah view dummy sebagai padding kanan kiri
        userNameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 23, height: userNameField.frame.height))
        userNameField.leftViewMode = .always
        userNameField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 23, height: userNameField.frame.height))
        userNameField.rightViewMode = .always
        userNameField.contentVerticalAlignment = .center
        userNameField.delegate = self
        userNameField.layer.borderWidth = 1
        userNameField.layer.borderColor = UIColor.clear.cgColor
    }
    
    private func setupDrawer() {
        self.drawerView.setRounded(
            size: CGSize(width: 50, height: 50),
            where: UIRectCorner(arrayLiteral: [.topRight,.topLeft])
        )
    }
    
    @objc func eyeButtonTapped(_ button: UIButton){
        viewModel.isPassSecure = !viewModel.isPassSecure
        self.passwordField.isSecureTextEntry = viewModel.isPassSecure
        self.eyeButton.setImage(
            UIImage(systemName: viewModel.isPassSecure ? "eye.slash.fill" : "eye.fill")?.withTintColor(.secondaryLabel,renderingMode: .alwaysOriginal),
            for: .normal)
    }
    
    @objc func signUpTapped() {
        let vc = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        vc.launchRef = self.launchRef
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension SignInViewController: SignInVMOutput {
    func setupViews() {
        self.setupRegisterLabel()
        self.setupPasswordField()
        self.setupUsernameField()
        self.loginButton.setRounded()
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text!.count < 5 {
            textField.layer.borderColor = UIColor.systemPink.cgColor
        } else {
            textField.layer.borderColor = UIColor.green.cgColor
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.clear.cgColor
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text!.count < 5 {
            textField.layer.borderColor = UIColor.systemPink.cgColor
        } else {
            textField.layer.borderColor = UIColor.green.cgColor
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
    }
}
