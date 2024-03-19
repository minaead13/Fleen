//
//  addCellViewModel.swift
//  Fleen
//
//  Created by Mina Eid on 04/02/2024.
//

import Foundation

class addsCellViewModel {
    let id: Int?
    let image: String?
    
    init(banners : Banner) {
        self.id = banners.id
        self.image = banners.image
    }
    
}
