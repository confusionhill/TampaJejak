//
//  Coordinator.swift
//  TampaJejak
//
//  Created by Farhandika on 13/05/22.
//

import UIKit

final class RootCoordinator {
    private var window: UIWindow?
    
    public init (window: UIWindow?){
        self.window = window
    }
    
    public func start() {
        self.window?.rootViewController = FakeLaunchScreenViewController(nibName: "FakeLaunchScreenViewController", bundle: nil)
        self.window?.makeKeyAndVisible()
    }
    
    private func chageRootVC(viewController vc: UIViewController) {
        UIView.transition(with: self.window!, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromBottom, animations: {
              self.window?.rootViewController = vc
        }, completion: nil)
    }
}
