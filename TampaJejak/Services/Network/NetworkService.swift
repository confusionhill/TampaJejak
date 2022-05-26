//
//  NetworkService.swift
//  TampaJejak
//
//  Created by Farhandika on 26/05/22.
//

import Firebase
import UIKit

final class NetworkService {
    let fireStore = Firestore.firestore()
    var ref: CollectionReference?
    
    public var getUser: User? {
        return Auth.auth().currentUser
    }
    
    public enum CollectionPath: String {
        case food = "Foods"
        case orderOrActivity = "activity"
    }
    
    public func fetchAllFood(
        completion: @escaping (Result<[FoodModel],Error>) -> ()
    ) {
        self.fetchCollectionData(path: .food) { res in
            switch res {
            case .failure(let e):
                completion(.failure(e))
            case .success(let snapshot):
                let docs = snapshot.documents.map{FoodModel(document: $0)}
                completion(.success(docs))
            }
        }
    }
    
    public func fetchMyActivity(
        completion: @escaping (Result<[OrderModel],Error>) -> ()
    ) {
        self.fetchCollectionData(path: .orderOrActivity) {[weak self] res in
            guard let self = self else { return }
            switch res {
            case .failure(let e):
                completion(.failure(e))
            case .success(let snapshot):
                do {
                    //Alhot mantop speed O(n^3) aka BAD ANJIRR
                    let docs = snapshot.documents.map {$0.data()}
                    let infos = try docs.map { childData -> OrderInfo in
                        let jsonData = try JSONSerialization.data(withJSONObject: childData["info"])
                        let decoded = try JSONDecoder().decode(OrderInfo.self, from: jsonData)
                        return decoded
                    }.filter({ info in
                        return info.uid == self.getUser?.uid
                    })
                    
                    let qrInfos = try docs.map({ childData -> QRInfo in
                        let jsonData = try JSONSerialization.data(withJSONObject: childData["qrInfo"])
                        let decoded = try JSONDecoder().decode(QRInfo.self, from: jsonData)
                        return decoded
                    }).filter({ info in
                        return info.uid == self.getUser?.uid
                    })
                    
                    var orderModels = [OrderModel]()
                    
                    for i in (0 ..< qrInfos.count) {
                        orderModels.append(OrderModel(
                            uuid: qrInfos[i].uuid,
                            qrInfo: qrInfos[i],
                            info: infos[i])
                        )
                    }
                    completion(.success(orderModels))
                } catch (let e) {
                    completion(.failure(e))
                }
            }
        }
    }
    
    public func sendOrder(
        orderModel: OrderModel,
        completion: @escaping (Result<String,Error>) -> ()
    ){
        let refPath = self.fireStore.document("activity/\(orderModel.uuid)")
        let foods = orderModel.info.foods.map { fm in
            return fm.nsDictionary
        }
        refPath.setData([
            "userID": self.getUser?.uid ?? "",
            "statusComplete": false,
            "qrInfo": [
                "userID": self.getUser?.uid ?? "",
                "message": orderModel.qrInfo.message,
                "uuid": orderModel.qrInfo.uuid
            ],
            "info": [
                "userID": self.getUser?.uid ?? "",
                "foods": foods,
                "totalPrice": orderModel.info.totalPrice,
                "paymentType": orderModel.info.paymentType.rawValue,
                "address": orderModel.info.address,
                "pickupType": orderModel.info.pickupType.rawValue,
            ],
        ])
        completion(.success("success"))
    }
    
    
    
    private func fetchCollectionData (
        path: CollectionPath,
        completion: @escaping (Result<QuerySnapshot,Error>) -> ()
    ) {
        self.ref = fireStore.collection(path.rawValue)
        self.ref?.getDocuments(completion: { snapshot, error in
            if error != nil {
                completion(.failure(error!))
                return
            }
            if let data = snapshot {
                completion(.success(data))
            }
        })
    }
}


extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}
