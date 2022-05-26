//
//  SignInViewModel.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import Foundation

protocol SignInVMOutput: AnyObject {
    func setupViews()
    func didSuccessAuth()
    func didFailAuth(message: String)
}

final class SignInViewModel {
    public static func setup(vc: SignInViewController) {
        let vm = SignInViewModel(output: vc)
        vc.viewModel = vm
    }
    
    weak var output: SignInVMOutput?
    var isPassSecure: Bool = true
    
    private var authService = AuthenticationService()
    
    private init(output: SignInVMOutput) {
        self.output = output
    }
    
    public func loadView() {
        self.output?.setupViews()
    }
    
    public func viewDidLoad() {
        
    }
    
    public func tryToLogin(
        username: String,
        password: String
    ) {
        self.authService.loginUser(username: username, password: password) { [unowned self] res in
            switch res {
            case .success(_):
                self.output?.didSuccessAuth()
            case .failure(let e):
                self.output?.didFailAuth(message: e.localizedDescription)
            }
        }
    }
}
