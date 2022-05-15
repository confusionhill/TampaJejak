//
//  OrderModel.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import Foundation

struct OrderModel {
    let qrInfo: QRInfo
    let info: OrderInfo
}

struct QRInfo {
    let message: String
    let uuid: String
}

struct OrderInfo {
    
    public enum PaymentType: String {
        case ovo, gopay, cash, dana, shopeePay
    }
    public enum PickupType: String {
        case pribadi, grab, gojek, maxim
    }
    
    var foods: [FoodModel]
    var totalPrice: Int {
        return foods.map({$0.price}).reduce(0, +)
    }
    var paymentType: PaymentType
    var address: String
    var pickupType: PickupType
    
    
}
