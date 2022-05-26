//
//  AccountViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit
import Firebase

class AccountViewController: BaseViewController {
    public weak var tabBarRef: TabBarDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapLogout(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            tabBarRef?.logoutTapped()
        } catch (let e){
            print(e.localizedDescription)
        }
    }

}
