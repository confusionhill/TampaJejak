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
        foodAdded = foodAdded.filter({ fm in
            return fm.uuid != model.uuid
        })
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
    
    public func updateQuantity(newVal: Int, indexPath: IndexPath){
        foodAdded[indexPath.row].quantity = newVal
    }
    
}
