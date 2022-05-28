//
//  SearchViewModel.swift
//  TampaJejak
//
//  Created by Farhandika on 28/05/22.
//

import Foundation

protocol SearchViewModelOutput: AnyObject {
    func setupViews()
    func didFinnishFilter()
}

final class SearchViewModel {
    static func config(vc: SearchViewController, foods: [FoodModel]) {
        let vm = SearchViewModel(foods: foods, output: vc)
        vc.viewModel = vm
    }
    
    init(foods: [FoodModel], output: SearchViewModelOutput) {
        self.initialFoods = foods
        self.foods = foods
        self.output = output
    }
    
    private let initialFoods: [FoodModel]
    private(set) var foods: [FoodModel]
    
    private(set) weak var output: SearchViewModelOutput?
    
    var row: Int {
        return self.foods.count
    }
    
    
    func viewDidLoad() {
        self.output?.setupViews()
    }
    
    func filterFood(textInput: String) {
        self.foods = initialFoods.filter({ fm in
            return fm.name.lowercased().contains(textInput.lowercased())
        })
        self.output?.didFinnishFilter()
    }
}
