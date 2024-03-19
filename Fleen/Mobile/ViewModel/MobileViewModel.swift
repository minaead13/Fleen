//
//  MobileViewModel.swift
//  Fleen
//
//  Created by Mina Eid on 15/01/2024.
//

import UIKit
import Alamofire

class MobileViewModel {
    
    var isMobileValid : Bool = false
    var isLoading : Observable<Bool> = Observable(false)
    var responseMessage : Observable<String?> = Observable(nil)
    var dataSource : MobileModel?
    
    func sendMobileNumber(viewController : UIViewController, phone : String , successCallback: (() -> Void)? = nil ){
        
        self.isLoading.value = true
        
        let parameters: [String: Any] = ["phone": phone]
        
        NetworkManager.instance.request(Endpoints.mobileNumberURL, parameters: parameters, method: .post, type: MobileModel.self, viewController: viewController) { [weak self] (data) in
            self?.success(data: data, successCallback: successCallback)
            
        
        }
    }
    
    private func success(data: BaseModel<MobileModel>? , successCallback: (() -> Void)?) {
        if let data = data {
            self.isLoading.value = false
            
            dataSource = data.data
            dataSource?.first_login = data.data?.first_login
            successCallback?()
        } else {
            self.isLoading.value = false
           
            if let message = data?.message {
                //self.swiftMessage(title: "Error", body: message, color: .error, layout: .messageView, style: .bottom)
                
            }
        }
    }
    
    
    func checkMobileTxt(_ mobileNumber: String) {
        isMobileValid = validateMobileNumber(mobileNumber)
    }
    
    func validateMobileNumber(_ value: String) -> Bool {
        let MOBILE_REGEX = #"^((\+|00)?966|0?)?5[0-9]{8}$"#
        let mobileTest = NSPredicate(format: "SELF MATCHES %@", MOBILE_REGEX)
        return mobileTest.evaluate(with: value)
    }
}


