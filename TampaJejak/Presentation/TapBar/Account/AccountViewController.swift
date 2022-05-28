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
    @IBOutlet weak var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        self.title = "My Account"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

}

extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            try Auth.auth().signOut()
            tabBarRef?.logoutTapped()
        } catch (let e){
            self.showSnackbar(message: e.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Account"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Logout"
        cell.selectionStyle = .none
        return cell
    }
    
    
}
