//
//  OrderDetailsModel.swift
//  Fleen
//
//  Created by Mina Eid on 25/02/2024.
//

import UIKit

struct OrderDetailsModel : Codable {
    let id: Int?
    let order_number, status, address, lat: String?
    let lon, address_name, payment_type: String?
  //  let payment_gatway: NSNull?
    let total: String?
    let items_count: Int?
    let created_at: String?
    let items: [Item]?
    let support_phone : String?
}



