//
//  CartVC+UITableView.swift
//  Fleen
//
//  Created by Mina Eid on 08/02/2024.
//

import UIKit

extension CartViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case locationTableView :
            return viewModel.numberOfAddressRows(in: section)
        case orderTableView :
            return viewModel.numberOfRows(in: section)
        case paymentTableView :
            return paymentArray.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        switch tableView {
            
        case orderTableView :
            let cell = orderTableView.dequeueReusableCell(withIdentifier: OrdersTableViewCell.identifier, for: indexPath) as! OrdersTableViewCell
            
            cell.config(cart: self.itemsCellDataSource[indexPath.row])
            
            cell.updateAction = { [weak self] increaseQty, id in
                self?.updateCart(qty: increaseQty, id: id ){
                    cell.countLabel.text = String(increaseQty)
                }
            }
            
            cell.deleteAction = { [weak self] productID, id in
                self?.presentDeleteConfirmationAlert(productID: productID, id: id) {
                    // Call deleteCart closure when delete action is confirmed
                    self?.deleteCart(productID: productID, id: id)
                }
            }
               
            
            return cell
            
        case locationTableView :
            let cell = locationTableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier, for: indexPath) as! LocationTableViewCell
            cell.titleLbl?.text = locationArray?[indexPath.row].type
            cell.subTitleLabel?.text = locationArray?[indexPath.row].default_address
            cell.id = locationArray?[indexPath.row].id
            cell.locImageView?.image = UIImage(named: "Vector")
            return cell
            
        case paymentTableView :
            let cell = paymentTableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier, for: indexPath) as! LocationTableViewCell
            cell.titleLbl?.text = paymentArray[indexPath.row].title
            cell.subTitleLabel.isHidden = true
            cell.id = paymentArray[indexPath.row].id
            cell.locImageView?.image = paymentArray[indexPath.row].image
            return cell
        default:
            return UITableViewCell()
        }
    }
        
    func updateCart(qty: Int, id: Int, completion: @escaping () -> Void) {
        viewModel.updateCartData(viewController: self, id: id, qty: qty){ [weak self] data in
            self?.totalPriceLabel.text = "\(data?.data?.total.orEmpty ?? "")"
            completion()
        }
    }
    
    func deleteCart(productID: Int, id: Int) {
        viewModel.deleteCartData(viewController: self, id: id, product_id: productID) { [weak self] data in
            guard let data = data?.data else {
                print("No data available.")
                return
            }
            self?.getData()
            self?.orderTableView.reloadData()
            DispatchQueue.main.async {
                self?.totalPriceLabel.text = data.total
            }
        }
    }
    
    func presentDeleteConfirmationAlert(productID: Int, id: Int, deleteAction: @escaping () -> Void) {
        let alertController = UIAlertController(title: "Delete Item".localized, message: "Are you sure you want to delete this item?".localized, preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete".localized, style: .destructive) { _ in
            deleteAction()
        }
        alertController.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch tableView {
            
        case orderTableView :
            print("")
        case locationTableView :
           
            if let selectedCell = locationTableView.cellForRow(at: indexPath)as? LocationTableViewCell {
                LocationTextField.text = selectedCell.titleLbl?.text
                viewModel.addressID = selectedCell.id
            }
            hideDropdown()
            
        case paymentTableView :
            
            if let selectedCell = paymentTableView.cellForRow(at: indexPath) as? LocationTableViewCell {
                paymentTextField.text = selectedCell.titleLbl?.text
                self.paymentTextField.setLeftImage(selectedCell.locImageView.image)
               // paymentTextField.leftImage = selectedCell.locImageView.image
                viewModel.paymentType = selectedCell.id
            }
            hideTableViewDropdown()
            
        default:
            print("none selection")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case orderTableView :
            return 60
        case locationTableView:
            return 40
        case paymentTableView:
            return 40
        default:
            return 40
        }
        
       
    }
        

}
