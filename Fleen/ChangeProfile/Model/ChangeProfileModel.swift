//
//  ChangeProfileModel.swift
//  Fleen
//
//  Created by Mina Eid on 11/03/2024.
//

import Foundation

struct ChangeProfileModel : Codable {
    let id : Int?
    let name , email , phone : String?
//    let area_id : Int?
//    let area : String?
    let shop_name , commercial_registration_number : String?
}
