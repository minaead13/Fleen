//
//  ContactModel.swift
//  Fleen
//
//  Created by Mina Eid on 06/03/2024.
//

import Foundation

struct ContactModel : Codable {
    let id : Int?
    let address , phone , whatsapp , email : String?
}
