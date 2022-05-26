//
//  OrderModel.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//

import Foundation

struct OrderModel: Decodable {
    var uuid:String
    let qrInfo: QRInfo
    let info: OrderInfo
}

struct QRInfo: Decodable {
    let message: String
    let uuid: String
    let uid: String?
    
    enum CodingKeys: String, CodingKey {
        case message, uuid
        case uid = "userID"
    }
}

struct OrderInfo: Decodable {
    var uid: String?
    var foods: [FoodModel]
    var totalPrice: Int
    var paymentType: PaymentSystem
    var address: String
    var pickupType: PickupType
    
    private enum CodingKeys : String, CodingKey {
        case uid = "userID"
        case foods,totalPrice = "totalPrice", paymentType, address, pickupType
    }
    
    init(
        foods: [FoodModel],
        totalPrice: Int,
        paymentType: PaymentSystem,
        address: String,
        pickupType: PickupType
    ) {
        self.foods = foods
        self.totalPrice = totalPrice
        self.paymentType = paymentType
        self.address = address
        self.pickupType = pickupType
    }
    
     init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.uid = try values.decode(String.self, forKey: .uid)
        self.foods = try values.decode([FoodModel].self, forKey: .foods)
        self.totalPrice = try values.decode(Int.self, forKey: .totalPrice)
        let payment = try values.decode(String.self, forKey: .paymentType)
        self.paymentType = PaymentSystem(rawValue: payment) ?? .cash
        self.address = try values.decode(String.self, forKey: .address)
        let pickup = try values.decode(String.self, forKey: .pickupType)
        self.pickupType = PickupType(rawValue: pickup) ?? .me
    }
}
