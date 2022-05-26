//
//  FoodInfoViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 17/05/22.
//

import UIKit

protocol FoodInfoViewControllerOutput: AnyObject {
    func didTapAddCart(foodModel: FoodModel)
}

class FoodInfoViewController: BaseViewController {
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var buyQuantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    init(foodModel: FoodModel, output: FoodInfoViewControllerOutput?) {
        super.init(nibName: "FoodInfoViewController", bundle: nil)
        self.output = output
        FoodInfoViewModel.config(vc: self, foodModel: foodModel)
    }
    
    weak var output: FoodInfoViewControllerOutput?
    var viewModel: FoodInfoViewModel!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .baseColor
        viewModel.viewDidload()
    }
    
    private func setupStackView() {
        self.stackView.layer.cornerRadius = 5
        self.stackView.layer.masksToBounds = true
        self.stackView.backgroundColor = .baseColor
    }
    
    private func setupAddButton() {
        self.addButton.setRounded()
        self.addButton.addTarget(self, action: #selector(self.didTapAddCart(_:)), for: .touchUpInside)
    }
    
    private func setupContent() {
        self.titleLabel.text = viewModel.foodModel.name
        self.descLabel.text = viewModel.foodModel.desc
        self.quantityLabel.text = "\(viewModel.foodModel.quantity)x"
        self.priceLabel.text = "Rp \(viewModel.foodModel.price)"
        self.buyQuantityLabel.text = "\(viewModel.bought)"
    }
    
    private func setupFoodImageView() {
        foodImageView.layer.cornerRadius = 20
        foodImageView.layer.masksToBounds = true
    }
    
    @objc func didTapAddCart(_ sender: UIButton) {
        if viewModel.bought <= 0 {
            self.showSnackbar(message: "No item added to cart")
        } else {
            let model = FoodModel(
                uuid: viewModel.foodModel.uuid, name: viewModel.foodModel.name,
                desc: viewModel.foodModel.desc, quantity: viewModel.bought,
                price: viewModel.foodModel.price, image: viewModel.foodModel.image)
            self.output?.didTapAddCart(foodModel: model)
        }
    }
    @IBAction func didTapMinus(_ sender: Any) {
        self.viewModel.bought -= (self.viewModel.bought == 0 ? 0 : 1)
        self.setupContent()
    }
    @IBAction func didTapPlus(_ sender: Any) {
        self.viewModel.bought += (self.viewModel.bought == viewModel.foodModel.quantity ? 0 : 1)
        self.setupContent()
    }
}

extension FoodInfoViewController: FoodInfoViewModelOutput {
    func setupViews() {
        self.setupFoodImageView()
        self.setupAddButton()
        self.setupStackView()
        self.setupContent()
    }
}
