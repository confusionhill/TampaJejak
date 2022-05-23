//
//  CheckoutViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 23/05/22.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var orderButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Checkout"
        self.setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: OrderTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OrderTableViewCell.identifier)
        tableView.register(UINib(nibName: TrackOrderTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TrackOrderTableViewCell.identifier)
    }
}

extension CheckoutViewController: UITableViewDelegate {
    
}

extension CheckoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrackOrderTableViewCell.identifier, for: indexPath) as! TrackOrderTableViewCell
                cell.hideInfoButton(state: true)
                cell.selectionStyle = .none
                return cell
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.identifier, for: indexPath) as! OrderTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
}
