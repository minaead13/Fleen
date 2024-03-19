//
//  AppSnackBar.swift
//  Fleen
//
//  Created by Mina Eid on 18/02/2024.
//

import Foundation
import SnackBar

class AppSnackBar: SnackBar{
    override var style: SnackBarStyle {
        var style = SnackBarStyle()
        style.background = .gold
        style.textColor = .black
        return style
    }
}
