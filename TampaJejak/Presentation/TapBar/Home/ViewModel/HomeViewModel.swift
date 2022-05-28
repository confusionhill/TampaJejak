//
//  HomeViewModel.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import Foundation

protocol HomeViewModelOutput: AnyObject {
    func setupViews()
    func didFinnishLoadingTopPicks()
    func didFinnishLoadingForYou()
    func didFailLoading(message: String)
}

final class HomeViewModel {
    public static func config(vc: HomeViewController) {
        let vm = HomeViewModel(output: vc)
        vc.viewModel = vm
    }
    
    private(set) var isLoaded: Bool = false
    
    private(set) var foodModels: [FoodModel] = []
    
    let networkService = NetworkService()
    
    fileprivate init(output: HomeViewModelOutput) {
        self.output = output
    }
    
    fileprivate weak var output: HomeViewModelOutput?
    
    public func viewDidLoad() {
        self.output?.setupViews()
        self.getAllFoods()
    }
    
    func getAllFoods() {
        self.networkService.fetchAllFood { [weak self] res in
            if let self = self {
                switch res {
                case .failure(let e):
                    self.output?.didFailLoading(message: e.localizedDescription)
                case .success(let foods):
                    foods.forEach { fm in
                        self.foodModels.addOrReplace(fm)
                    }
                    self.isLoaded = true
                    self.output?.didFinnishLoadingTopPicks()
                }
            }
        }
    }
}
