//
//  FoodCategoryViewModel.swift
//  TampaJejak
//
//  Created by Farhandika on 17/05/22.
//

import Foundation

protocol FoodCategoryViewModelOutput: AnyObject {
    func setupViews()
    func openFoodInfo(model: FoodModel)
    func didSuccessFetchFood()
    func didFailFetchFood(message: String)
    func showAlert(message:String)
}

final class FoodCategoryViewModel {
    static func config(vc: FoodCategoryViewController, foodID: String?) {
        let vm = FoodCategoryViewModel(output: vc, foodID: foodID)
        vc.viewModel = vm
    }
    
    private(set) var foodData: [FoodModel] = []
    
    var dataCount: Int {
        return self.foodData.count + 1
    }
    
    private let networkService = NetworkService()
    
    init(output: FoodCategoryViewModelOutput, foodID: String?) {
        self.output = output
        self.foodID = foodID
    }
    weak var output: FoodCategoryViewModelOutput?
    private var foodID: String?
    
    func viewDidLoad() {
        self.output?.setupViews()
        self.fetchFoodData()
        if self.foodID != nil {
            let selected = self.foodData.filter { fm in
                return fm.uuid == self.foodID!
            }
            if selected.isEmpty && foodID != nil {
                self.output?.showAlert(message: "Food has been deleted from the database")
            }
            if !selected.isEmpty {
                self.output?.openFoodInfo(model: selected[0])
            }
        }
        
    }
    
    public func fetchFoodData() {
        networkService.fetchAllFood { [weak self] res in
            guard let self = self else { return }
            switch res {
            case .failure(let e):
                self.output?.didFailFetchFood(message: e.localizedDescription)
            case .success(let foods):
                foods.forEach {self.foodData.addOrReplace($0)}
                self.output?.didSuccessFetchFood()
            }
        }
    }
    
    
}
