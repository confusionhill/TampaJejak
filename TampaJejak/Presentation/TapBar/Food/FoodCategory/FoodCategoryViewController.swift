//
//  FoodCategoryViewController.swift
//  TampaJejak
//
//  Created by Farhandika on 16/05/22.
//

import UIKit

class FoodCategoryViewController: BaseViewController {
    
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: HomeViewControllerDelegate?
    
    init(foodID id: String) {
        super.init(nibName: "FoodCategoryViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        super.loadView()
        self.title = "Categrory"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(self.didTapExitCategory))
        self.collectionView.backgroundColor = .baseColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.setupCart()
        self.setupCollectionView()
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

}

extension FoodCategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCategoryHeaderCollectionViewCell.identifier, for: indexPath) as! FoodCategoryHeaderCollectionViewCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainFoodCollectionViewCell.identifier, for: indexPath) as! MainFoodCollectionViewCell
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.backgroundColor = .white
        return cell
    }
}

extension FoodCategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 5, left: 17, bottom: 0, right: 17)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = BaseViewController()
        vc.view.backgroundColor = .white
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(),.large()]
        }
        self.present(vc, animated: true, completion: nil)
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
