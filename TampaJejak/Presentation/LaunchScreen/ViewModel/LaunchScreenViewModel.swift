//
//  LaunchScreenViewModel.swift
//  TampaJejak
//
//  Created by Farhandika on 17/05/22.
//

import Foundation

protocol LaunchScreenViewModelOutput: AnyObject {
    func navigateInitialViewController()
}


final class LaunchScreenViewModel {
    
    weak var output: LaunchScreenViewModelOutput?
    var isLogin: Bool = true
    
    func viewDidLoad(){
        self.output?.navigateInitialViewController()
    }
}
