//
//  CartViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit

class CartViewController: BaseViewController {
    
    weak var delegate: HomeViewControllerDelegate?
    @IBOutlet weak var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        self.title = "Checkout"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapExit(_ sender: UIButton) {
        self.delegate?.didTapExit()
    }
}
