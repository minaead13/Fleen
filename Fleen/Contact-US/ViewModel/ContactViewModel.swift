//
//  ContactViewModel.swift
//  Fleen
//
//  Created by Mina Eid on 06/03/2024.
//

import UIKit

class ContactViewModel {
    
    var isLoading : Observable<Bool> = Observable(false)
    
    func getContactData(viewController : UIViewController, api_response: @escaping (BaseModel<ContactModel>?) -> Void) {
        
        self.isLoading.value = true
        
        NetworkManager.instance.request(Endpoints.countactURL, parameters: nil, method: .get, type: ContactModel.self, viewController: viewController) { [weak self] (data) in
            self?.success(data: data, api_response: api_response)
            
        }
    }
    
    private func success(data: BaseModel<ContactModel>? , api_response: @escaping (BaseModel<ContactModel>?) -> Void ) {
        if data != nil {
            api_response(data)
            self.isLoading.value = false
        } else {
            self.isLoading.value = false
            if let message = data?.message {
                //self.swiftMessage(title: "Error", body: message, color: .error, layout: .messageView, style: .bottom)
                
            }
        }
    }
}
