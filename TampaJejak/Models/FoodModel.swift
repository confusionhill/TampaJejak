//
//  FoodModel.swift
//  TampaJejak
//
//  Created by Farhandika on 15/05/22.
//
import Firebase
import Foundation

struct FoodModel: Codable, Equatable {
    let uuid: String
    let name: String
    let desc: String
    var quantity: Int
    let price: Int
    let image: String
    
    var dictionary: [String: Any] {
            return [
                "uuid": uuid,
                "name": name,
                "desc": desc,
                "quantity": quantity,
                "price": price,
                "image": image,
            ]
        }
    var nsDictionary: NSDictionary {
            return dictionary as NSDictionary
    }
    
    init(document: QueryDocumentSnapshot) {
        self.uuid = document["uuid"] as? String ?? UUID().uuidString
        self.name = document["name"] as? String ?? ""
        self.desc = document["desc"] as? String ?? ""
        self.quantity = document["quantity"] as? Int ?? 0
        self.price = document["price"] as? Int ?? 0
        self.image = document["image"] as? String ?? ""
        return
    }
    
    init(
        uuid: String,
        name: String,
        desc: String,
        quantity: Int,
        price: Int,
        image: String
    ){
        self.uuid = uuid
        self.name = name
        self.desc = desc
        self.quantity = quantity
        self.price = price
        self.image = image
    }
}
