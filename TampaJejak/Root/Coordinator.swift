//
//  Coordinator.swift
//  TampaJejak
//
//  Created by Farhandika on 13/05/22.
//

import UIKit

final class RootCoordinator {
    private var window: UIWindow?
    public let shared: RootCoordinator = RootCoordinator()
    
    public func start() {
        
    }
    
    func navigateToAuth() {
        
    }
    
    func navigateToHome() {
        
    }
    
    private func chageRootVC(viewController vc: UIViewController) {
        UIView.transition(with: self.window!, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromBottom, animations: {
              self.window?.rootViewController = vc
        }, completion: nil)
    }
}
