//
//  OrderDetailsVC+UITableView.swift
//  Fleen
//
//  Created by Mina Eid on 27/02/2024.
//

import Foundation
import UIKit

extension OrderDetailsViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.numberOftotalOrdersRows(in: section)).orEmpty
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrdersTableViewCell.identifier, for: indexPath) as! OrdersTableViewCell
        cell.increaseBtn.isHidden = true
        cell.deleteBtn.isHidden = true
        cell.decreaseBtn.isHidden = true
        cell.config(cart: itemsCellDataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
