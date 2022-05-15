//
//  AccountViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit

class AccountViewController: BaseViewController {
    public weak var tabBarRef: TabBarDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func didTapLogout(_ sender: UIButton) {
        tabBarRef?.logoutTapped()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
