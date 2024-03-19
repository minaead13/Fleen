//
//  CartViewModel.swift
//  Fleen
//
//  Created by Mina Eid on 08/02/2024.
//

import Foundation
import UIKit

class CartViewModel {
    
    var isLoading : Observable<Bool> = Observable(false)
    var cartCellDataSource : Observable<[CartCellViewModel]> = Observable(nil)
    var dataSource : CartModel?
    var addressDataSource : [AddressModel]?
    var amDeliveryTime : [Time]?
    var pmDeliveryTime : [Time]?
    var addressID : Int?
    var deliveryTime : Int?
    var paymentType : Int?

    func numberOfRows(in section : Int) -> Int {
        return cartCellDataSource.value?.count ?? 0
    }
    
    func numberOfAddressRows(in section : Int) -> Int {
        return addressDataSource?.count ?? 0
    }
    
    func getCartData(viewController : UIViewController , api_response: @escaping (BaseModel<CartModel>?) -> Void ){
        self.isLoading.value = true
        NetworkManager.instance.request(Endpoints.cartURL, parameters: nil, method: .get, type: CartModel.self, viewController: viewController) { [weak self] (data) in
            api_response(data)
            self?.success(data: data)
        }
    }
    
    private func success(data: BaseModel<CartModel>?) {
        if data != nil {
            self.isLoading.value = false
            dataSource = data?.data
            dataSource?.total = data?.data?.total
            mapCellData()
            
            if let deliveryTimes = dataSource?.delivery_times {
                if !deliveryTimes.isEmpty {
                    // Delivery times available
                    print("Delivery times count: \(deliveryTimes.count)")
                    for deliveryTime in deliveryTimes {
                        print("Delivery time type: \(deliveryTime.type ?? "No type")")
                        print("Times:")
                        for time in deliveryTime.times ?? [] {
                            print("ID: \(time.id ?? 0), Time: \(time.time ?? "No time")")
                        }
                    }
                } else {
                    print("No delivery times available.")
                }
            } else {
                print("Delivery times array is nil.")
            }
            
            
            
        } else {
            self.isLoading.value = false
            if let message = data?.message {
                //self.swiftMessage(title: "Error", body: message, color: .error, layout: .messageView, style: .bottom)
            }
        }
    }
    
    func mapCellData(){
        self.cartCellDataSource.value = self.dataSource?.items?.compactMap({ CartCellViewModel(cart: $0)})
    }
    
    
    func updateCartData(viewController : UIViewController, id : Int , qty : Int , api_response: @escaping (BaseModel<UpdateCart>?) -> Void){
       // self.isLoading.value = true
        let url = Endpoints.updateItemURL + "/\(id)"
        let parameters: [String: Any] = ["qty": qty]
        NetworkManager.instance.request(url, parameters: parameters, method: .post, type: UpdateCart.self, viewController: viewController) { [weak self] (data) in
            self?.successs(data: data, api_response: api_response)
        }
    }
    
    private func successs(data: BaseModel<UpdateCart>? , api_response: @escaping (BaseModel<UpdateCart>?) -> Void) {
        if data != nil {
         //   self.isLoading.value = false
            api_response(data)
        } else {
          //  self.isLoading.value = false
            
        }
    }
    
    func deleteCartData(viewController : UIViewController, id : Int , product_id : Int , api_response: @escaping (BaseModel<DeleteItem>?) -> Void){
        let url = Endpoints.deleteItemURL + "/\(id)"
        let parameters: [String: Any] = ["product_id": product_id]
        NetworkManager.instance.request(url, parameters: parameters, method: .delete, type: DeleteItem.self, viewController: viewController) { [weak self] (data) in
            self?.successData(data: data, api_response: api_response)
        }
    }
    
    private func successData(data: BaseModel<DeleteItem>? , api_response: @escaping (BaseModel<DeleteItem>?) -> Void) {
        if data != nil {
            api_response(data)
        } else {
            self.isLoading.value = false
        }
    }
    
    func getAddresses(viewController : UIViewController, api_response: @escaping (BaseModel<[AddressModel]>?) -> Void){
        NetworkManager.instance.request(Endpoints.addressesURL, parameters: nil, method: .get, type: [AddressModel].self, viewController: viewController) { [weak self] (data) in
            self?.successAddressData(data: data ,api_response: api_response)
        }
    }
    
    private func successAddressData(data: BaseModel<[AddressModel]>?, api_response: @escaping (BaseModel<[AddressModel]>?) -> Void ) {
        if data != nil {
            self.isLoading.value = false
            api_response(data)
            addressDataSource = data?.data
        } else {
            self.isLoading.value = false
        }
    }
    
    func sendOrder(viewController : UIViewController, address : Int, delivery_time : Int, payment_type : Int , api_response: @escaping (BaseModel<addToCart>?) -> Void){
        let parameters: [String: Any] = [
            "address": address,
            "delivery_time" : delivery_time,
            "payment_type" : payment_type
        ]
        NetworkManager.instance.request(Endpoints.orderURL, parameters: parameters, method: .post, type: addToCart.self, viewController: viewController) { [weak self] (data) in
            self?.successOrderData(data: data ,api_response: api_response)
        }
    }
    
    private func successOrderData(data: BaseModel<addToCart>?, api_response: @escaping (BaseModel<addToCart>?) -> Void ) {
        if data != nil {
            self.isLoading.value = false
            api_response(data)

        } else {
            self.isLoading.value = false
        }
    }
    
    func checkID(viewController: UIViewController) -> Bool {
        let errorTitle = "Error".localized
        
        var isValid = true
        
        if addressID == nil || addressID == 0 {
            viewController.showAlertError(title: errorTitle, message: "Please choose your address".localized)
            isValid = false
        }
        
        if paymentType == nil || paymentType == 0 {
            viewController.showAlertError(title: errorTitle, message: "Please choose your payment method".localized)
            isValid = false
        }
        
        if deliveryTime == nil || deliveryTime == 0 {
            viewController.showAlertError(title: errorTitle, message: "Please choose your delivery time".localized)
            isValid = false
        }
        
        return isValid
    }
    
    
}
