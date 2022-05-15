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
    @IBOutlet weak var loginLabel: UILabel!
    
    lazy var eyeButton: UIButton = {
        let button = UIButton(frame: CGRect(
            x: 0, y: 0,
            width: 23, height: 23))
        button.setTitle(" ", for: .normal)
        button.setImage(UIImage(systemName: "eye.slash.fill")?.withTintColor(.secondaryLabel,renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    weak var launchRef: FakeLaunchOuput?
    var viewModel: RegisterViewModel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        RegisterViewModel.config(vc: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        RegisterViewModel.config(vc: self)
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    @IBAction func didTapRegister(_ sender: UIButton) {
        self.launchRef?.didTapLogin()
    }
    
    @IBAction func didTapGender(_ sender: UIButton) {
        let vc = PickerDisplayViewController()
        vc.output = self
        vc.data = ["","Male","Female","Gender Fluid"]
        vc.view.backgroundColor = .white
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    private func setupGenderButton() {
        self.genderButton.contentHorizontalAlignment = .left
        self.genderButton.backgroundColor = .secondarySystemBackground
    }
    
    private func setupFields() {
        fullNameField.delegate = self
        fullNameField.setAuthInputConfig()
        fullNameField.setDefaultInput()
        
        usernameField.delegate = self
        usernameField.setAuthInputConfig()
        usernameField.setDefaultInput()
        
        emailField.delegate = self
        emailField.setAuthInputConfig()
        emailField.setDefaultInput()
        
        passwordField.delegate = self
        passwordField.isSecureTextEntry = true
        passwordField.setAuthInputConfig()
        passwordField.setDefaultInput()
        self.passwordField.rightView = eyeButton
        
        rePasswordField.delegate = self
        rePasswordField.isSecureTextEntry = true
        rePasswordField.setAuthInputConfig()
        rePasswordField.setDefaultInput()
        
        phoneField.delegate = self
        phoneField.setAuthInputConfig()
        phoneField.setDefaultInput()
    }
    
    @objc func eyeButtonTapped(_ button: UIButton){
        viewModel.isPassSecure = !viewModel.isPassSecure
        self.passwordField.isSecureTextEntry = viewModel.isPassSecure
        self.rePasswordField.isSecureTextEntry = viewModel.isPassSecure
        self.eyeButton.setImage(
            UIImage(systemName: viewModel.isPassSecure ? "eye.slash.fill" : "eye.fill")?.withTintColor(.secondaryLabel,renderingMode: .alwaysOriginal),
            for: .normal)
    }
    
    private func setupLoginLabel() {
        let attributedText = NSMutableAttributedString(string: "Already have an account?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        attributedText.append(NSAttributedString(string: " Sign in!",attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.primarygreen]))
        loginLabel.attributedText = attributedText
        loginLabel.numberOfLines = 1
        loginLabel.textAlignment = .center
        
        self.loginLabel.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapLoginLabel))
        tapgesture.numberOfTapsRequired = 1
        self.loginLabel.addGestureRecognizer(tapgesture)
    }
    
    @objc func didTapLoginLabel() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
    }
}

extension RegisterViewController: RegisterVMOutput {
    func setupViews() {
        self.title = "Create your account"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        eyeButton.addTarget(self, action: #selector(self.eyeButtonTapped(_:)), for: .touchUpInside)
        registerButton.setRounded()
        self.setupGenderButton()
        self.setupFields()
        setupLoginLabel()
    }
    
    
}

extension RegisterViewController: PickerDisplayDelegate {
    func didFinnishPickItem(name: String) {
        print("Finnished \(name)")
        if name != "" {
            self.genderButton.setTitle(name, for: .normal)
        } else {
            self.genderButton.setTitle("Gender", for: .normal)
        }
    }
    func didTapClosePicker() {
        self.dismiss(animated: true, completion: nil)
    }
}
