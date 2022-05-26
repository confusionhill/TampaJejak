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
    
    fileprivate init(output: HomeViewModelOutput) {
        self.output = output
    }
    
    fileprivate weak var output: HomeViewModelOutput?
    
    public func viewDidLoad() {
        self.output?.setupViews()
        self.isLoaded = true
        self.output?.didFinnishLoadingForYou()
    }
}
