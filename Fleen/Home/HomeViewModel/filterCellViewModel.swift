//
//  filterCellViewModel.swift
//  Fleen
//
//  Created by Mina Eid on 04/02/2024.
//

import UIKit

class filterCellViewModel {
    var isSelected: Bool = false
    
    let title : String?
    let id : Int?
    
    init(filter : Category){
        self.title = filter.name
        self.id = filter.id
    }
}
