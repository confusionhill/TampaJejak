//
//  SignInViewModel.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import Foundation

protocol SignInVMOutput: AnyObject {
    func setupViews()
}

final class SignInViewModel {
    public static func setup(vc: SignInViewController) {
        let vm = SignInViewModel(output: vc)
        vc.viewModel = vm
    }
    
    weak var output: SignInVMOutput?
    var isPassSecure: Bool = true
    
    private init(output: SignInVMOutput) {
        self.output = output
    }
    
    public func loadView() {
        self.output?.setupViews()
    }
    
    public func viewDidLoad() {
        
    }
}
