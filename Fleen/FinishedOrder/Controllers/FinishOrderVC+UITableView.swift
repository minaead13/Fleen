//
//  FinishOrderVC+UITableView.swift
//  Fleen
//
//  Created by Mina Eid on 22/02/2024.
//


import UIKit

extension FinishedOrdersViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOftotalOrdersRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoOrdersTableViewCell.identifier, for: indexPath) as! NoOrdersTableViewCell
        cell.caseDeliveryLabel.textColor = UIColor.gold
        cell.selectionStyle = .none
        cell.config(viewModel: self.totalOrdersCellDataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 127
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = totalOrdersCellDataSource[indexPath.row].id
        self.openDetails(productsID: item.orEmpty)
    }

}
