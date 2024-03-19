//
//  File.swift
//  Fleen
//
//  Created by Mina Eid on 22/01/2024.
//

import Foundation
import UIKit

class RegisterViewModel {
    
    var items : [AreasModel]?
    var isLoading : Observable<Bool> = Observable(false)
    var isLoadingRegister : Observable<Bool> = Observable(false)
    var filteredItems: [AreasModel] = []
    var isValidTextField : Bool = false
    var check : Bool?
    var errorMessage: String = ""
    
    init() {
        filteredItems = items ?? []
    }
    
    func filterItems(with searchText: String) {
        if searchText.isEmpty {
            filteredItems = items ?? []
        } else {
            filteredItems = (items ?? []).filter { $0.name?.lowercased().contains(searchText.lowercased()) == true }
        }
        
    }
    
    func getAreas(viewController : UIViewController, api_response: @escaping (BaseModel<[AreasModel]>?) -> Void) {
        
        self.isLoading.value = true
        
        NetworkManager.instance.request(Endpoints.areasURL, parameters: nil, method: .get, type: [AreasModel].self, viewController: viewController) { [weak self] (data) in
            api_response(data)
            self?.success(data: data)
            
        }
    }
    
    private func success(data: BaseModel<[AreasModel]>? ) {
        if data != nil {
            self.isLoading.value = false
        } else {
            self.isLoading.value = false
            if let message = data?.message {
                //self.swiftMessage(title: "Error", body: message, color: .error, layout: .messageView, style: .bottom)
                
            }
        }
    }
    
    func sendRegistrationRequest(viewController : UIViewController, name : String, email : String , area : String , shop_name : String , commercial_registration_number : String , successCallback: (() -> Void)? = nil ){
        
        self.isLoading.value = true
        
        let parameters: [String: Any] = [
            "name": name,
            "email": email,
            "area": area,
            "shop_name": shop_name,
            "commercial_registration_number": commercial_registration_number
        ]
        
        NetworkManager.instance.request(Endpoints.registration, parameters: parameters, method: .post, type: RegisterModel.self, viewController: viewController) { [weak self] (data) in
            
            self?.success(data: data, successCallback: successCallback)
            
        }
    }
    
    private func success(data: BaseModel<RegisterModel>? , successCallback: (() -> Void)?) {
        if data != nil {
            self.isLoadingRegister.value = false
            successCallback?()
        } else {
            self.isLoadingRegister.value = false
            if let message = data?.message {
                //self.swiftMessage(title: "Error", body: message, color: .error, layout: .messageView, style: .bottom)
            }
        }
    }
    
    func validateFields(name: String, email: String, region: String, shopName: String, comNumber: String) -> Bool {
        if name == "" {
            errorMessage = "Please Enter your name".localized
            return false
        }
        
        if !email.isEmpty && !validateEmail(value: email) {
            errorMessage = "Please enter your mail in correct format".localized
            return false
        }
        
        
        if region == "" {
            errorMessage = "Please Enter your region".localized
            return false
        }
        
        if shopName == "" {
            errorMessage = "Please Enter your shop name".localized
            return false
        }
        
        if comNumber == "" {
            errorMessage = "Please Enter your commercial registration number".localized
            return false
        }
        
        return true
    }
    
    func validateEmail(value: String) -> Bool {
        let EMAIL_REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", EMAIL_REGEX)
        let result = emailTest.evaluate(with: value)
        print("RESULT \(result)")
        return result
    }
    
    
}

