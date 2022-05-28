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
    func openSearch()
}

final class FoodCategoryViewModel {
    static func config(vc: FoodCategoryViewController, food: FoodModel?) {
        let vm = FoodCategoryViewModel(output: vc, food:food)
        vm.loadSearch = false
        vc.viewModel = vm
    }
    
    static func config(vc: FoodCategoryViewController) {
        let vm = FoodCategoryViewModel(output: vc, food:nil)
        vm.loadSearch = true
        vc.viewModel = vm
    }
    
    private var loadSearch: Bool = false
    
    private(set) var foodData: [FoodModel] = []
    
    var dataCount: Int {
        return self.foodData.count + 1
    }
    
    private var initial = true
    
    private let networkService = NetworkService()
    
    init(output: FoodCategoryViewModelOutput, food: FoodModel?) {
        self.output = output
        self.food = food
    }
    weak var output: FoodCategoryViewModelOutput?
    private var food: FoodModel?
    
    func viewDidLoad() {
        self.output?.setupViews()
        self.fetchFoodData()
    }
    
    public func filter(){
        if self.food != nil {
            let selected = self.foodData.filter { fm in
                return fm == food
            }
            if selected.isEmpty {
                self.output?.showAlert(message: "Food is currently not available")
            } else {
                self.output?.openFoodInfo(model: selected[0])
            }
        }
        
        if loadSearch {
            self.output?.openSearch()
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
                if self.initial {
                    self.filter()
                    self.initial = false
                }
                self.output?.didSuccessFetchFood()
            }
        }
    }
    
    
}
