//
//  NetworkManager.swift
//  Fleen
//
//  Created by Mina Eid on 24/01/2024.
//

import Foundation
import Alamofire
import UIKit
import MOLH

class NetworkManager {
    
    static let instance = NetworkManager()
    let errorMsg = "Network Failed, Please try again.".localized
    
    func request<T: Codable>(_ strURL: String, parameters: [String : Any]?, method: HTTPMethod, type: T.Type, viewController: UIViewController, hasLoading: Bool = true, api_response: @escaping (BaseModel<T>?) -> Void){
        let headers = getHeaders()
        let parameters = parameters ?? [:]
        
#if DEBUG
        print("Parameters:", parameters)
#endif
        
        AF.request(strURL, method: method, parameters: parameters, headers: headers ).responseDecodable(of: BaseModel<T>.self) { (response) -> Void in
            print(response.debugDescription)
            print(response.description)
            
            switch response.result {
            case .success:
                if let statusCode = response.response?.statusCode {
                    print(statusCode)
                    switch statusCode {
                    case 200..<300:
                        if let resJson = response.data {
                            do {
                                let model = try JSONDecoder().decode(BaseModel<T>.self, from: resJson)
                                api_response(model)
                            } catch {
                                print("Bad request error")
                               // viewController.swiftMessage(title: "Error", body: error.localizedDescription, color: .error, layout: .messageView, style: .bottom)
                                viewController.showAlertError(title: "Error".localized, message: self.errorMsg)
                        //        KRProgressHUD.dismiss() // Dismiss the progress HUD
                                api_response(nil)
                            }
                        }
                    case 400..<500:
                        // Handle bad request error
                        print("Bad request error")
                        if let resJson = response.data {
                            do {
                                let model = try JSONDecoder().decode(BaseModel<T>.self, from: resJson)
                                let errorMessage = model.message ?? "Unknown error"
                               // viewController.swiftMessage(title: "Error", body: errorMessage, color: .error, layout: .messageView, style: .bottom)
                                viewController.showAlertError(title: "Error".localized, message: errorMessage)
                            } catch {
                                print(error.localizedDescription)
                               // viewController.swiftMessage(title: "Error", body: error.localizedDescription, color: .error, layout: .messageView, style: .bottom)
                                viewController.showAlertError(title: "Error".localized, message: self.errorMsg)
                            }
                        }
                       // KRProgressHUD.dismiss() // Dismiss the progress HUD
                        api_response(nil)
                        
                        // Add more cases as needed
                        
                    default:
                        break
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
               // viewController.swiftMessage(title: "Error", body: error.localizedDescription, color: .error, layout: .messageView, style: .bottom)
                viewController.showAlertError(title: "Error".localized, message: self.errorMsg)
            //    KRProgressHUD.dismiss() // Dismiss the progress HUD
                api_response(nil)
            }
        }
    }
    
    
    func getHeaders() -> HTTPHeaders {
//        var lang : String = ""
//        if LanguageHelper.language.currentLanguage() == "ar" {
//            lang = "ar"
//        } else {
//            lang = "en"
//        }
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "lang" : MOLHLanguage.currentAppleLanguage(),
           "Authorization" : "Bearer " + (UserDefaults.standard.string(forKey: "token") ?? "")
        ]

        return headers
    }
    
}
    
    

