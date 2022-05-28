//
//  LaunchScreenViewModel.swift
//  TampaJejak
//
//  Created by Farhandika on 17/05/22.
//

import Foundation
import Firebase
protocol LaunchScreenViewModelOutput: AnyObject {
    func navigateInitialViewController()
}


final class LaunchScreenViewModel {
    
    weak var output: LaunchScreenViewModelOutput?
    var isLogin: Bool = true
    private var authService: AuthenticationService = AuthenticationService()
    
    public var user: User? {
        return authService.getUser
    }
    
    func viewDidLoad(){
        self.output?.navigateInitialViewController()
    }
    
    func tryListeningAuth() {
        authService.getUserState {[unowned self] result in
           
        }
    }
    
    func stopListeningAuth() {
        self.authService.stopGetUserState()
    }
}
