//
//  CheckoutViewModel.swift
//  TampaJejak
//
//  Created by Farhandika on 26/05/22.
//

import Foundation

public enum PickupType: String {
    case me = "Self Pick up"
}

public enum PaymentSystem: String {
    case cash = "Cash"
    
    var sub: String {
        return ""
    }
}

protocol CheckoutViewModelOutput: AnyObject {
    func setupViews()
    func didSuccessSubmitOrder()
    func didFailSubmitOrder(message: String)
}

class CheckoutViewModel {
    static func config(vc: CheckoutViewController) {
        let vm = CheckoutViewModel(output: vc)
        vc.viewModel = vm
    }
    init(output: CheckoutViewModelOutput) {
        self.output = output
    }
    
    var itemCount: Int {
        return CartService.shared.itemCount + 1
    }
    
    var totalPrice: Int {
        var total = 0
        CartService.shared.foodAdded.forEach { fm in
            total += fm.quantity * fm.price
        }
        return total
    }
    
    var foodData: [FoodModel] {
        return CartService.shared.foodAdded
    }
    
    var selectedPayment: PaymentSystem = .cash
    var selectedPickup: PickupType = .me
    var address: String = ""
    
    let networkService = NetworkService()
    
    private weak var output: CheckoutViewModelOutput?
    
    func viewDidLoad() {
        self.output?.setupViews()
    }
    
    func submitOrder() {
        let uuid = UUID().uuidString
        let orderModel = OrderModel(
            uuid: uuid,
            qrInfo: QRInfo(
                message: self.address,
                uuid: uuid, uid: nil),
            info: OrderInfo(
                foods: self.foodData,
                totalPrice: self.totalPrice,
                paymentType: self.selectedPayment,
                address: self.address,
                pickupType: self.selectedPickup))
        
        self.networkService.sendOrder(orderModel: orderModel) { [weak self] res in
            guard let self = self else { return }
            switch res {
            case .success(_):
                CartService.shared.clearCart()
                self.output?.didSuccessSubmitOrder()
            case .failure(let e):
                self.output?.didFailSubmitOrder(message: e.localizedDescription)
            }
        }
    }
}
