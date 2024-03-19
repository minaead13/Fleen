//
//  BaseModel.swift
//  Fleen
//
//  Created by Mina Eid on 24/01/2024.
//

import Foundation

struct BaseModel <T: Codable>: Codable {
    
    var code  : Int?
    var message : String?
    var data    : T?
    
}
