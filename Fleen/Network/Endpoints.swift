//
//  Endpoints.swift
//  Fleen
//
//  Created by Mina Eid on 24/01/2024.
//

import Foundation

class Endpoints: NSObject {
    
    // MARK: - Api url
    private static let BASE_API_URL =
    "https://fleen.vision-code.com/api/v1"
    
    //MARK: - MobileNumber
    private static let mobile = "/login"
    
    static var mobileNumberURL : String {return BASE_API_URL + mobile }
    
    //MARK: - verifyCode
    private static let verifyCode = "/vertifyCode"
    
    static var verifyCodeURL : String {return BASE_API_URL + verifyCode }
    
    //MARK: - areas
    private static let areas = "/areas"
    
    static var areasURL : String {return BASE_API_URL + areas }
    
    //MARK: - areas
    private static let register = "/completeregistration"
    
    static var registration : String {return BASE_API_URL + register }
    
    //MARK: - Home
    private static let home = "/home"
    static var homeURL : String {return BASE_API_URL + home }
    
    //MARK: - itemDetails
    private static let item = "/product"
    static var itemDetailsURL : String {return BASE_API_URL + item }
    
    //MARK: - addToCart
    private static let addToCart = "/cart/store"
    static var addToCartURL : String {return BASE_API_URL + addToCart }
    
    //MARK: - addLocation
    private static let addLocation = "/address/store"
    private static let deleteLocation = "/address/delete/"
    static var addLocationURL : String {return BASE_API_URL + addLocation }
    static var deleteLocationURL : String {return BASE_API_URL + deleteLocation }
    
    //MARK: - Cart
    private static let cart = "/cart"
    static var cartURL : String {return BASE_API_URL + cart }
    
    private static let updateItem = "/update"
    static var updateItemURL : String {return BASE_API_URL + cart + updateItem  }
    
    private static let deleteItem = "/delete"
    static var deleteItemURL : String {return BASE_API_URL + cart + deleteItem  }
    
    //MARK: - Address
    private static let address = "/addresses"
    static var addressesURL : String {return BASE_API_URL + address }
    
    //MARK: - Order
    private static let order = "/order/store"
    private static let orders = "/orders"
    static var orderURL : String {return BASE_API_URL + order }
    static var ordersURL : String { return BASE_API_URL + orders }
    static var orderDetailsURL : String { return BASE_API_URL + "/order" }
    static var reorderURL : String { return BASE_API_URL + "/reorder" }
    
    //MARK: - CartCount
    private static let count = "/cart_count"
    static var countURL : String {return BASE_API_URL + count }
    
    //MARK: - Contact-Us
    private static let countact = "/contactus"
    static var countactURL : String {return BASE_API_URL + countact }
    
    //MARK: - Profile
    private static let profile = "/profile"
    private static let editprofile = "/edit"
    static var profileURL : String {return BASE_API_URL + profile  }
    static var editprofileURL : String {return BASE_API_URL + profile + editprofile  }
    
}
