//
//  TotalOrdersViewModel.swift
//  Fleen
//
//  Created by Mina Eid on 22/02/2024.
//

import Foundation

class TotalOrdersCellViewModel {
    let id: Int?
    let order_number: String?
    let icon: String?
    let status, total: String?
    let items_count: Int?
    let created_at: String?
    
    
    init(totalOrders : TotalOrders) {
        self.id = totalOrders.id
        self.icon = totalOrders.icon
        self.order_number = totalOrders.order_number
        self.status = totalOrders.status
        self.total = totalOrders.total
        self.items_count = totalOrders.items_count
        self.created_at = totalOrders.created_at
    }
}
