//
//  HomeModel.swift
//  Fleen
//
//  Created by Mina Eid on 04/02/2024.
//

import Foundation

// MARK: - HomeModel
struct Home : Codable{
    let banners: [Banner]
    let categories: [Category]
    var products: Products
}

// MARK: - Banner
struct Banner : Codable{
    let id: Int?
    let image: String?
}

// MARK: - Category
struct Category : Codable{
    let id: Int?
    let name: String?
}

// MARK: - Products
struct Products : Codable{
    var data: [productsDatum]?
    let links: Links?
    let meta: Meta?
}

// MARK: - Datum
struct productsDatum : Codable{
    let id: Int?
    let name: String?
    let image: String?
    let unit: String?
}

// MARK: - Links
struct Links : Codable{
    let first, last: String?
   // let prev, next: NSNull
}

// MARK: - Meta
struct Meta : Codable{
    let current_page, from, last_page: Int?
    let links: [Link]?
    let path: String?
    let per_page, to, total: Int?
}

// MARK: - Link
struct Link : Codable{
    let url: String?
    let label: String?
    let active: Bool?
}

// MARK: - Count
struct CountModel : Codable{
    let count : Int?
}
