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
        tableView.register(UINib(nibName: OrderCodeTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OrderCodeTableViewCell.identifier)
        tableView.register(UINib(nibName: TrackOrderTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TrackOrderTableViewCell.identifier)
    }
}

extension ActivityViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("mememe")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ActivityViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier:OrderCodeTableViewCell.identifier, for: indexPath) as! OrderCodeTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier:TrackOrderTableViewCell.identifier, for: indexPath) as! TrackOrderTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.identifier, for: indexPath) as! OrderTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension ActivityViewController: InfoButtonOutput {
    func didTapInfo() {
        let vc = QRCodeViewController()
        vc.view.backgroundColor = .white
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        self.present(vc, animated: true, completion: nil)
    }
}
