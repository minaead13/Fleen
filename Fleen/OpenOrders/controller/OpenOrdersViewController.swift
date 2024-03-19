//
//  OpenOrdersViewController.swift
//  Fleen
//
//  Created by Mina Eid on 19/02/2024.
//

import UIKit

class OpenOrdersViewController: UIViewController {

    @IBOutlet weak var noOrderStack: UIStackView!
    @IBOutlet weak var noOrderLabel: UILabel!
    @IBOutlet weak var openTableView: UITableView!
    
    
    let viewModel = TotalOrderViewModel()
    var spinnerView: UIView?
    var totalOrdersCellDataSource = [TotalOrdersCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingViewModel()
        setUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        viewModel.getHomeData(viewController: self, status: "open")
    }
    
    private func setUI(){
        noOrderStack.isHidden = true
        setTableViewCell()
        setData()
        setFonts()
    }
    
    private func setTableViewCell(){
        openTableView.registerCell(cell: NoOrdersTableViewCell.self)
    }
    
    private func setData(){
        noOrderLabel.text = "There are no requests".localized
    }
    
    private func setFonts(){
        noOrderLabel.font = UIFont(name: "DMSans-Bold", size: 17)
    }
    
    func bindingViewModel(){
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self,
                  let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self.showLoadingIndicator()
                } else {
                    self.hideLoadingIndicator()
                }
            }
        }
        
        viewModel.totalOrdersCellDataSource.bind { [weak self] totalOrders in
            guard let self = self else { return }
            
            if let totalOrders = totalOrders {
                
                if totalOrders.isEmpty {
                    self.noOrderStack.isHidden = false
                    self.openTableView.isHidden = true
                } else {
                    self.noOrderStack.isHidden = true
                    self.openTableView.isHidden = false  
                    self.totalOrdersCellDataSource = totalOrders
                    self.openTableView.reloadData()
                }
            }
        }
    }
   
    func showLoadingIndicator() {
        spinnerView = displaySpinner(onView: self.view)
    }
        
    func hideLoadingIndicator() {
        if let sv = spinnerView{
            removeSpinner(spinner: sv)
        }
    }
    
    func openDetails(productsID : Int){
        guard let ordersDetails = viewModel.retriveMovie(with: productsID ) else { return }
        
        let itemDetailsViewModel = OrderDetailsViewModel(orderDetails: ordersDetails)
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
          
          if let itemController = storyboard.instantiateViewController(withIdentifier: "OrderDetailsViewController") as? OrderDetailsViewController {
              itemController.viewModel = itemDetailsViewModel
              DispatchQueue.main.async {
                  self.navigationController?.pushViewController(itemController, animated: true)
              }
          }
    }
}



