//
//  itemDetailsViewModel.swift
//  Fleen
//
//  Created by Mina Eid on 05/02/2024.
//

import Foundation
import UIKit
class itemDetailsViewModel {
    
    var products : productsDatum
    var dataSource : itemModel?
    var id : Int
    var isLoading : Observable<Bool> = Observable(false)
    
    init(productsDetails: productsDatum) {
        self.products = productsDetails
        self.id = productsDetails.id.orEmpty
    }
    
    func getDetails(viewController : UIViewController, id : String, api_response: @escaping (BaseModel<itemModel>?) -> Void) {
        
        self.isLoading.value = true
        let url = Endpoints.itemDetailsURL + "/" + id
        NetworkManager.instance.request(url, parameters: nil, method: .get, type: itemModel.self, viewController: viewController) { [weak self] (data) in
            api_response(data)
            self?.success(data: data)
            
        }
    }
    
    private func success(data: BaseModel<itemModel>? ) {
        if data != nil {
            dataSource = data?.data
            self.isLoading.value = false
        } else {
            self.isLoading.value = false
        }
    }
    
    func sendToCart(viewController : UIViewController, productID : Int, qty : Int, countryID: Int, prodcutDegree: Int, successCallback: (() -> Void)? = nil ) {
        
        self.isLoading.value = true
        let parameters: [String: Any] = [
            "product_id": productID,
            "qty" : qty,
            "country_id" : countryID,
            "product_degree" : prodcutDegree
        ]
        
        
        NetworkManager.instance.request(Endpoints.addToCartURL, parameters: parameters, method: .post, type: addToCart.self, viewController: viewController) { [weak self] (data) in
          
            self?.successData(data: data, successCallback: successCallback)
            
        }
    }
    
    private func successData(data: BaseModel<addToCart>?,  successCallback: (() -> Void)? ) {
        if data != nil {
            successCallback?()
            self.isLoading.value = false
        } else {
            self.isLoading.value = false
        }
    }
    
    
    
}
