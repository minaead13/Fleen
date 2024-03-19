//
//  TableView+Extensions.swift
//  Fleen
//
//  Created by Mina Eid on 29/01/2024.
//

import UIKit

extension UITableView {
    func registerCell<Cell : UITableViewCell>(cell : Cell.Type){
        let nibName = String(describing: cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
}


