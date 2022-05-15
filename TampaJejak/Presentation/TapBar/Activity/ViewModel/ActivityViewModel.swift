//
//  ActivityViewModel.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import Foundation

protocol ActivityViewModelOutput: AnyObject {
    func setupViews()
}

class ActivityViewModel {
    fileprivate weak var output: ActivityViewModelOutput?
    
    public static func config(vc: ActivityViewController) {
        let vm = ActivityViewModel(output: vc)
        vc.viewModel = vm
    }
    
    fileprivate init(output: ActivityViewModelOutput?) {
        self.output = output
    }
    
    func viewDidLoad() {
        self.output?.setupViews()
    }
}
