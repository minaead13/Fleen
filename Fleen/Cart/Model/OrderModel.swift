//
//  OrderModel.swift
//  Fleen
//
//  Created by Mina Eid on 30/01/2024.
//

import UIKit

struct payment {
    var title: String
    var image : UIImage
    var id : Int
}

// MARK: - CartModel
struct CartModel : Codable{
    let items: [Item]?
    var total: String?
    let delivery_times: [DeliveryTime]?
}
// MARK: - Item
struct Item : Codable{
    let id: Int?
    let product_id, name: String?
    let image: String?
    let price, unit: String?
    let qty : Int?
}
// MARK: - DeliveryTime
struct DeliveryTime : Codable {
    let type: String?
    let times: [Time]?
}

// MARK: - Time
struct Time : Codable{
    let id: Int?
    let time: String?
}

// MARK: - UpdateCart
struct UpdateCart : Codable {
    let qty , total : String?
}

// MARK: - DeleteItem
struct DeleteItem : Codable {
    let items: [ItemCart]?
    let total: String?
}

// MARK: - Item
struct ItemCart : Codable {
    let id: Int?
    let product_id, name: String
    let image: String?
    let price, unit: String?
    let qty: Int?
}

// MARK: - Address
struct AddressModel : Codable {
    let id: Int?
    let default_address, address, type: String?
}
