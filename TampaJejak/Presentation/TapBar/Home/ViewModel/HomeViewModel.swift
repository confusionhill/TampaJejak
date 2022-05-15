//
//  HomeViewModel.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import Foundation

protocol HomeViewModelOutput: AnyObject {
    func setupViews()
}

final class HomeViewModel {
    public static func config(vc: HomeViewController) {
        let vm = HomeViewModel(output: vc)
        vc.viewModel = vm
    }
    
    fileprivate init(output: HomeViewModelOutput) {
        self.output = output
    }
    
    fileprivate weak var output: HomeViewModelOutput?
    
    public func viewDidLoad() {
        self.output?.setupViews()
    }
}
