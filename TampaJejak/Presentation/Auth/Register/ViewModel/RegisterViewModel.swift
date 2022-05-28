//
//  RegisterViewModel.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import Foundation

protocol RegisterVMOutput: AnyObject {
    func setupViews()
    func didSuccessRegister()
    func didFailRegister(message: String)
}

final class RegisterViewModel {
    static func config(vc: RegisterViewController) {
        let vm = RegisterViewModel(output: vc)
        vc.viewModel = vm
    }
    init(output: RegisterVMOutput) {
        self.output = output
    }
    fileprivate weak var output: RegisterVMOutput?
    
    private let authService = AuthenticationService()
    
    public var isPassSecure: Bool = true
    
    public func viewDidLoad(){
        self.output?.setupViews()
    }
    
    public func signUpUser(signUpModel: SignUpUserModel) {
        self.authService.registerUser(signUpModel: signUpModel) { [weak self] res in
            switch res {
            case .success(_):
                self?.output?.didSuccessRegister()
            case .failure(let e):
                self?.output?.didFailRegister(message: e.localizedDescription)
            }
        }
    }
}
