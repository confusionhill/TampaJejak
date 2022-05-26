//
//  CartService.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import Foundation

class CartService {
    static let shared = CartService()
    
    private(set) var foodAdded:[FoodModel] = []
    
    var itemCount: Int {
        return foodAdded.count
    }
    
    public func addFood(model: FoodModel){
        foodAdded.addOrReplace(model)
    }
    
    public func getFoodAdded() -> [FoodModel] {
        return self.foodAdded
    }
    
    public func deleteFood(foodID: String) {
        self.foodAdded = self.foodAdded.filter({$0.uuid != foodID})
    }
    
    public func clearCart() {
        self.foodAdded = []
    }
    
}
