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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nil)
        ActivityViewModel.config(vc: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        ActivityViewModel.config(vc: self)
    }
    
    override func loadView() {
        super.loadView()
        self.title = "My Activity"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.viewWillAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.viewDidLoad()
    }

}

extension ActivityViewController: ActivityViewModelOutput {
    func setupViews(){
        self.setupTableView()
    }
    
    func didSuccessFetchOrders() {
        self.tableView.reloadData()
    }
    func didFailFetchOrders(message: String) {
        self.showSnackbar(message: message)
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
        return viewModel.numberOfSection
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows(indexPathSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier:OrderCodeTableViewCell.identifier, for: indexPath) as! OrderCodeTableViewCell
            cell.selectionStyle = .none
            let code = viewModel.orders[indexPath.section].uuid
            cell.setupContent(code: code)
            return cell
        }
        if indexPath.row == viewModel.getNumberOfRows(indexPathSection: indexPath.section) - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier:TrackOrderTableViewCell.identifier, for: indexPath) as! TrackOrderTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            let model = viewModel.orders[indexPath.section].info
            cell.setContent(price: model.totalPrice)
            cell.indexPath = indexPath
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.identifier, for: indexPath) as! OrderTableViewCell
        cell.selectionStyle = .none
        let model = viewModel.orders[indexPath.section].info.foods[indexPath.row - 1]
        cell.setupContent(foodModel: model)
        return cell
    }
    
}

extension ActivityViewController: InfoButtonOutput {
    func didTapInfo(indexPath: IndexPath) {
        let vc = QRCodeViewController()
        let model = viewModel.orders[indexPath.section]
        vc.qrInfo = model.qrInfo
        vc.setupContent(price: model.info.totalPrice, code: model.uuid)
        vc.view.backgroundColor = .white
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        self.present(vc, animated: true, completion: nil)
    }
}
