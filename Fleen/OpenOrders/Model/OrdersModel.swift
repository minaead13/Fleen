//
//  OrdersModel.swift
//  Fleen
//
//  Created by Mina Eid on 22/02/2024.
//

import Foundation

// MARK: - OrdersModel
struct OrdersModel : Codable {
    let data: [TotalOrders]?
    let links: Links?
    let meta: Meta?
}

// MARK: - TotalOrders
struct TotalOrders : Codable {
    let id: Int?
    let order_number: String?
    let icon: String?
    let status, total: String?
    let items_count: Int?
    let created_at: String?
}
