//
//  PlainCarouselTableViewCell.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import UIKit

class PlainCarouselTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    public static let identifier = "PlainCarouselTableViewCell"
    
    weak var homeOutput: HomeViewControllerOutput?
    var foods: [FoodModel] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: MainFoodCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MainFoodCollectionViewCell.identifier)
        collectionView.backgroundColor = .baseColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension PlainCarouselTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 5, left: 17, bottom: 0, right: 17)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.homeOutput?.didTapFood(indexPath: indexPath)
    }
}

extension PlainCarouselTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.foods.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainFoodCollectionViewCell.identifier, for: indexPath) as! MainFoodCollectionViewCell
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.backgroundColor = .white
        let model = foods[indexPath.row]
        cell.setContent(model: model)
        return cell
    }
    
    
}

extension PlainCarouselTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2 - 20 , height: collectionView.frame.size.height - 20 )
    }
}
