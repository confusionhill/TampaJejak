//
//  FoodInfoViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 17/05/22.
//

import UIKit

protocol FoodInfoViewControllerOutput: AnyObject {
    func didTapAddCart()
}

class FoodInfoViewController: UIViewController {
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var buyQuantityLabel: UILabel!
    
    init(foodID: String, output: FoodInfoViewControllerOutput?) {
        super.init(nibName: "FoodInfoViewController", bundle: nil)
        self.output = output
    }
    
    weak var output: FoodInfoViewControllerOutput?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .baseColor
        self.setupFoodImageView()
        self.setupAddButton()
        self.stackView.layer.cornerRadius = 5
        self.stackView.layer.masksToBounds = true
        self.stackView.backgroundColor = .baseColor
    }
    
    private func setupAddButton() {
        self.addButton.setRounded()
        self.addButton.addTarget(self, action: #selector(self.didTapAddCart(_:)), for: .touchUpInside)
    }
    
    private func setupFoodImageView() {
        foodImageView.layer.cornerRadius = 20
        foodImageView.layer.masksToBounds = true
    }
    
    @objc func didTapAddCart(_ sender: UIButton) {
        self.output?.didTapAddCart()
    }
}
