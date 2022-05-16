//
//  FoodCategoryViewModel.swift
//  TampaJejak
//
//  Created by Farhandika on 17/05/22.
//

import Foundation

protocol FoodCategoryViewModelOutput: AnyObject {
    func setupViews()
    func openFoodInfo(foodID: String)
}

final class FoodCategoryViewModel {
    static func config(vc: FoodCategoryViewController, foodID: String?) {
        let vm = FoodCategoryViewModel(output: vc, foodID: foodID)
        vc.viewModel = vm
    }
    init(output: FoodCategoryViewModelOutput, foodID: String?) {
        self.output = output
        self.foodID = foodID
    }
    weak var output: FoodCategoryViewModelOutput?
    private var foodID: String?
    
    func viewDidLoad() {
        self.output?.setupViews()
        if let foodID = foodID {
            self.output?.openFoodInfo(foodID: foodID)
        }
    }
}
