//
//  FoodInfoViewModel.swift
//  TampaJejak
//
//  Created by Farhandika on 26/05/22.
//

import Foundation

protocol FoodInfoViewModelOutput: AnyObject {
    func setupViews()
    
}

final class FoodInfoViewModel {
    static func config(
        vc: FoodInfoViewController,
        foodModel: FoodModel
    ) {
        let vm = FoodInfoViewModel(foodModel: foodModel, output: vc)
        vc.viewModel = vm
    }
    
    init(foodModel: FoodModel, output: FoodInfoViewModelOutput) {
        self.foodModel = foodModel
        self.output = output
    }
    
    weak private(set) var output: FoodInfoViewModelOutput?
    let foodModel: FoodModel
    var bought: Int = 0
    
    func viewDidload() {
        self.output?.setupViews()
    }
}
