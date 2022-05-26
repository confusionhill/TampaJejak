//
//  CartViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit

class CartViewController: BaseViewController {
    
    @IBOutlet weak var checkoutButton: UIButton!
    weak var delegate: HomeViewControllerDelegate?
    @IBOutlet weak var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        self.title = "Checkout"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        checkoutButton.setRounded()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(self.didTapExitCart))
    }
    
    @IBAction func didTapCheckout(_ sender: Any) {
        if CartService.shared.itemCount == 0 {
            self.showSnackbar(message: "There's no item in the Basket")
            return
        }
        let vc = CheckoutViewController(nibName: "CheckoutViewController", bundle: nil)
        vc.delegate = self.delegate
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapExitCart() {
        self.delegate?.didTapExit()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CartInfoTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CartInfoTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .baseColor
    }

    @IBAction func didTapExit(_ sender: UIButton) {
        self.delegate?.didTapExit()
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartService.shared.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartInfoTableViewCell.identifier, for: indexPath) as!  CartInfoTableViewCell
        cell.backgroundColor = .clear
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        cell.selectionStyle = .none
        cell.setupCell(delegate: self, index: indexPath)
        let model = CartService.shared.foodAdded[indexPath.row]
        cell.setContent(foodModel: model)
        return cell
    }
    
}

extension CartViewController: CartInfoCellDelegate {
    func didTapDelete(index: IndexPath) {
        let model = CartService.shared.foodAdded[index.row]
        CartService.shared.deleteFood(foodID: model.uuid)
        tableView.deleteRows(at: [index], with: .automatic)
        tableView.reloadData()
    }
}
