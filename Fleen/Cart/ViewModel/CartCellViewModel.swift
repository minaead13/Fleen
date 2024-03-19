//
//  CartCellViewModel.swift
//  Fleen
//
//  Created by Mina Eid on 08/02/2024.
//

import Foundation

class CartCellViewModel {
    let id: Int?
    let productID, name: String?
    let image: String?
    let price, unit: String?
    let qty : Int?
    init(cart : Item){
        self.id = cart.id
        self.productID = cart.product_id
        self.name = cart.name
        self.image = cart.image
        self.price = cart.price
        self.unit = cart.unit
        self.qty = cart.qty
    }
    
    
}
