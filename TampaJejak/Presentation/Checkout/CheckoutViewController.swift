//
//  CheckoutViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 23/05/22.
//

import UIKit

class CheckoutViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    
    weak var delegate: HomeViewControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nil)
        CheckoutViewModel.config(vc: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        CheckoutViewModel.config(vc: self)
    }
    
    var viewModel: CheckoutViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Checkout"
        self.viewModel.viewDidLoad()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: OrderTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OrderTableViewCell.identifier)
        tableView.register(UINib(nibName: TrackOrderTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TrackOrderTableViewCell.identifier)
        tableView.register(UINib(nibName: "PaymentTableViewCell", bundle: nil), forCellReuseIdentifier: PaymentTableViewCell.identifier)
    }
    
    @IBAction func didTapPlaceOrder(_ sender: UIButton) {
        viewModel.submitOrder()
    }
}

extension CheckoutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension CheckoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.itemCount
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == viewModel.itemCount-1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrackOrderTableViewCell.identifier, for: indexPath) as! TrackOrderTableViewCell
                cell.hideInfoButton(state: true)
                cell.selectionStyle = .none
                cell.setContent(price: viewModel.totalPrice)
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.identifier, for: indexPath) as! OrderTableViewCell
            cell.selectionStyle = .none
            let model = viewModel.foodData[indexPath.row]
            cell.setupContent(foodModel: model)
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PaymentTableViewCell.identifier) as! PaymentTableViewCell
            cell.setContent(paymentType: viewModel.selectedPayment)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentTableViewCell.identifier) as! PaymentTableViewCell
        if indexPath.section == 1 {
            cell.setContent(paymentType: viewModel.selectedPayment)
        } else {
            cell.setContentForPickup(pickupType: viewModel.selectedPickup)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
}

extension CheckoutViewController: CheckoutViewModelOutput {
    func setupViews() {
        self.setupTableView()
        self.totalPriceLabel.text = "Rp \(viewModel.totalPrice)"
    }
    
    func didSuccessSubmitOrder() {
        self.delegate?.didTapExit()
    }
    
    func didFailSubmitOrder(message: String) {
        self.showSnackbar(message: "You are not connected to the Internet")
    }
}
