//
//  FoodCategoryViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 16/05/22.
//

import UIKit

protocol CategoryDelegate: AnyObject {
    func didTapCell(foodModel: FoodModel)
}

class FoodCategoryViewController: BaseViewController {
    
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: HomeViewControllerDelegate?
    
    var category: String = "All Category"
    
    var viewModel: FoodCategoryViewModel!
    
    init(loadFood food: FoodModel?) {
        super.init(nibName: "FoodCategoryViewController", bundle: nil)
        FoodCategoryViewModel.config(vc: self, food: food)
    }
    
    init(loadSearch: Bool) {
        super.init(nibName: "FoodCategoryViewController", bundle: nil)
        FoodCategoryViewModel.config(vc: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        FoodCategoryViewModel.config(vc: self, food: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.title = "Category"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(self.didTapExitCategory))
        self.collectionView.backgroundColor = .baseColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    private func setupCart() {
        cartButton.setTitle(" ", for: .normal)
        cartButton.setImage(
            UIImage(
                systemName: "cart.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal),
            for: .normal)
        self.cartButton.setCircular()
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: MainFoodCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MainFoodCollectionViewCell.identifier)
        self.collectionView.register(UINib(
            nibName: FoodCategoryHeaderCollectionViewCell.identifier, bundle: nil),
                                     forCellWithReuseIdentifier: FoodCategoryHeaderCollectionViewCell.identifier)
    }
    
    @objc func didTapExitCategory() {
        self.delegate?.didTapExit()
    }
    
    @IBAction func didTapCart(_ sender: UIButton) {
        let vc = CartViewController(nibName: "CartViewController", bundle: nil)
        vc.delegate = self.delegate
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
}

extension FoodCategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCategoryHeaderCollectionViewCell.identifier, for: indexPath) as! FoodCategoryHeaderCollectionViewCell
            cell.setTitle(title: self.category)
            cell.delegate = self
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainFoodCollectionViewCell.identifier, for: indexPath) as! MainFoodCollectionViewCell
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.backgroundColor = .white
        let model = viewModel.foodData[indexPath.row-1]
        cell.setContent(model: model)
        return cell
    }
}

extension FoodCategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 5, left: 17, bottom: 0, right: 17)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.openFoodInfo(model: viewModel.foodData[indexPath.row-1])
    }
}

extension FoodCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.layer.bounds.width - 34, height: 120)
        }
        return CGSize(width: UIScreen.main.bounds.width/2 - 25 , height: 195 )
    }
}

extension FoodCategoryViewController: FoodCategoryViewModelOutput {
    func openSearch() {
        self.didTapSearch()
    }
    
    func setupViews() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.setupCart()
        self.setupCollectionView()
    }
    
    func openFoodInfo(model: FoodModel){
        let vc = FoodInfoViewController(foodModel: model,output: self)
        vc.view.backgroundColor = .white
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.large()]
        }
        self.present(vc, animated: true, completion: nil)
    }
}

extension FoodCategoryViewController: FoodInfoViewControllerOutput {
    func didTapAddCart(foodModel: FoodModel) {
        CartService.shared.addFood(model: foodModel)
        self.dismiss(animated: true) {
            self.viewModel.fetchFoodData()
        }
    }
    
    func didSuccessFetchFood() {
        self.collectionView.reloadData()
    }
    
    func didFailFetchFood(message: String) {
        self.showSnackbar(message: message)
    }
    
    func showAlert(message:String) {
        self.showSnackbar(message: message)
    }
}

extension FoodCategoryViewController: HeaderDelegate {
    func didTapSearch() {
        let vc = SearchViewController(foods: viewModel.foodData, delegate: self)
        self.present(vc, animated: true)
    }
}

extension FoodCategoryViewController: CategoryDelegate {
    func didTapCell(foodModel: FoodModel) {
        self.dismiss(animated: true)
        self.openFoodInfo(model: foodModel)
    }
}
