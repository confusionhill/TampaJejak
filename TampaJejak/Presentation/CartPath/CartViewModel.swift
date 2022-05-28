//
//  CartViewModel.swift
//  TampaJejak
//
//  Created by Farhandika on 26/05/22.
//

import Foundation

protocol CartViewModelOutput: AnyObject {
    func setupViews()
}

class CartViewModel {
    
    static func config(vc: CartViewController) {
        
    }
    
    private(set) weak var output: CartViewModelOutput?
    
    
}
