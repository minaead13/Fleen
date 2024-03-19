//
//  DeleteViewModel.swift
//  Fleen
//
//  Created by Mina Eid on 12/03/2024.
//

import UIKit

class DeleteViewModel {
    var isLoading : Observable<Bool> = Observable(false)
 
    
    func deleteLocation(viewController : UIViewController, id : Int ,successCallback: (() -> Void)? = nil ) {
        
        self.isLoading.value = true
        let url = Endpoints.deleteLocationURL + "\(id)"
        NetworkManager.instance.request(url, parameters: nil, method: .delete, type: addToCart.self, viewController: viewController) { [weak self] (data) in
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

