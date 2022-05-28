//
//  ActivityViewModel.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import Foundation

protocol ActivityViewModelOutput: AnyObject {
    func setupViews()
    func didSuccessFetchOrders()
    func didFailFetchOrders(message: String)
}

class ActivityViewModel {
    fileprivate weak var output: ActivityViewModelOutput?
    
    private let networkService = NetworkService()
    
    public static func config(vc: ActivityViewController) {
        let vm = ActivityViewModel(output: vc)
        vc.viewModel = vm
    }
    
    fileprivate init(output: ActivityViewModelOutput?) {
        self.output = output
    }
    
    private(set) var orders = [OrderModel]()
    
    var numberOfSection: Int {
        return orders.count
    }
    
    func getNumberOfRows(indexPathSection idx: Int) -> Int {
        return 2 + orders[idx].info.foods.count
    }
    
    func viewWillAppear() {
        self.getMyActivity()
    }
    
    func viewDidLoad() {
        self.output?.setupViews()
        self.output?.didSuccessFetchOrders()
    }
    
    public func getMyActivity() {
        networkService.fetchMyActivity { [weak self] res in
            guard let self = self else { return }
            switch res {
            case .failure(let e):
                self.output?.didFailFetchOrders(message: e.localizedDescription)
            case .success(let orders):
                self.orders = orders
                self.output?.didSuccessFetchOrders()
            }
        }
    }
}
