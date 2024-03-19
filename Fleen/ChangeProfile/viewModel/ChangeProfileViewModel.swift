//
//  ChangeProfileViewModel.swift
//  Fleen
//
//  Created by Mina Eid on 11/03/2024.
//

import UIKit

class ChangeProfileViewModel {
    
    var isLoading : Observable<Bool> = Observable(false)
    var errorMessage: String = ""
    
    func getProfileData(viewController : UIViewController, api_response: @escaping (BaseModel<ChangeProfileModel>?) -> Void ){
        
        self.isLoading.value = true
        
        NetworkManager.instance.request(Endpoints.profileURL, parameters: nil, method: .get, type: ChangeProfileModel.self, viewController: viewController) { [weak self] (data) in
            
            self?.success(data: data, api_response: api_response)
            
        }
    }
    
    private func success(data: BaseModel<ChangeProfileModel>? , api_response: @escaping (BaseModel<ChangeProfileModel>?) -> Void ) {
        if data != nil {
            self.isLoading.value = false
            api_response(data)
        } else {
            self.isLoading.value = false
        }
    }
    
    func editProfileData(viewController : UIViewController, name : String, email : String  , shop_name : String , commercial_registration_number : String , successCallback: (() -> Void)? = nil ){
        
        
        let parameters: [String: Any] = [
            "name": name,
            "email": email,
            "shop_name": shop_name,
            "commercial_registration_number": commercial_registration_number
        ]
        
        NetworkManager.instance.request(Endpoints.editprofileURL, parameters: parameters, method: .post, type: ChangeProfileModel.self, viewController: viewController) { [weak self] (data) in
            
            self?.success(data: data, successCallback: successCallback)
            
        }
    }
    
    private func success(data: BaseModel<ChangeProfileModel>? , successCallback: (() -> Void)?) {
        if data != nil {
            successCallback?()
        } else {
        }
    }
    
    
    func validateFields(name: String, email: String, shopName: String, comNumber: String) -> Bool {
        if name == "" {
            errorMessage = "Please Enter your name".localized
            return false
        }
        
        if !email.isEmpty && !validateEmail(value: email) {
            errorMessage = "Please enter your mail in correct format".localized
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

