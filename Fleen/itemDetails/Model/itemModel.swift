//
//  itemModel.swift
//  Fleen
//
//  Created by Mina Eid on 05/02/2024.
//

import Foundation

struct itemModel : Codable{
    let id: Int?
    let name: String?
    let image: String?
    let price, unit, unit_contains_count, sub_unit: String?
    let description: String?
    let countries: [Country]?
}
    
// MARK: - Country
struct Country : Codable{
    let id: Int?
    let name: String?
    let degrees: [Degree]?
}

// MARK: - Degree
struct Degree : Codable{
    let id: Int?
    let name: String?
}

struct addToCart : Codable {
    
}
