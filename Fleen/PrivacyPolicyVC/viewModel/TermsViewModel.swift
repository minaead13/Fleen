//
//  TermsViewModel.swift
//  Fleen
//
//  Created by Mina Eid on 06/03/2024.
//

import UIKit

class TermsViewModel {
    
    var isLoading : Observable<Bool> = Observable(false)
    
    func getRules(viewController : UIViewController, endoPoint : String, api_response: @escaping (BaseModel<TermsModel>?) -> Void) {
        
        self.isLoading.value = true
        let url = "https://fleen.vision-code.com/api/v1/\(endoPoint)"
        NetworkManager.instance.request(url, parameters: nil, method: .get, type: TermsModel.self, viewController: viewController) { [weak self] (data) in
            self?.success(data: data, api_response: api_response)
            
        }
    }
    
    private func success(data: BaseModel<TermsModel>? , api_response: @escaping (BaseModel<TermsModel>?) -> Void ) {
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
