//
//  RegisterViewModel.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import Foundation

protocol RegisterVMOutput: AnyObject {
    func setupViews()
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
    
    public var isPassSecure: Bool = true
    
    public func viewDidLoad(){
        self.output?.setupViews()
    }
}
