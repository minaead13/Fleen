//
//  productsCellViewModel.swift
//  Fleen
//
//  Created by Mina Eid on 04/02/2024.
//

import Foundation

class productsCellViewModel {
    let title : String?
    let subTitle : String?
    let image : String?
    let id : Int?
    init(products : productsDatum ){
        self.title = products.name
        self.image = products.image
        self.subTitle = products.unit
        self.id = products.id
    }
}
