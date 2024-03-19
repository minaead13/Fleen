//
//  Any+Extensions.swift
//  Fleen
//
//  Created by Mina Eid on 14/01/2024.
//

import Foundation

extension Optional where Wrapped == String {
    var orEmpty: String {
        self ?? ""
    }
}

extension Optional where Wrapped == Int {
    var orEmpty: Int {
        self ?? 0
    }
}

extension Optional where Wrapped == Double {
    var orEmpty: Double {
        self ?? 0.0
    }
}
