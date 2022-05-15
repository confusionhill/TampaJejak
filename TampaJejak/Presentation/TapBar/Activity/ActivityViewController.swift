//
//  ActivityViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit

class ActivityViewController: BaseViewController {
    
    var viewModel: ActivityViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        self.title = "My Activity"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }

}

extension ActivityViewController: ActivityViewModelOutput {
    func setupViews(){
        self.setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: OrderTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OrderTableViewCell.identifier)
    }
}

extension ActivityViewController: UITableViewDelegate {
    
}

extension ActivityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.identifier, for: indexPath) as! OrderTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    
}
