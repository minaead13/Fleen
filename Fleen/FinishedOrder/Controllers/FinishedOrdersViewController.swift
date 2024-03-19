//
//  FinishedOrdersViewController.swift
//  Fleen
//
//  Created by Mina Eid on 19/02/2024.
//

import UIKit

class FinishedOrdersViewController: UIViewController {

    @IBOutlet weak var noOrderStack: UIStackView!
    @IBOutlet weak var noOrderLabel: UILabel!
    @IBOutlet weak var finishTableView: UITableView!
    
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
        viewModel.getHomeData(viewController: self, status: "finish")
    }
    
    private func setUI(){
        noOrderStack.isHidden = true
        setTableViewCell()
        setData()
        setFonts()
    }
    
    private func setTableViewCell(){
        finishTableView.registerCell(cell: NoOrdersTableViewCell.self)
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
                    self.finishTableView.isHidden = true
                } else {
                    self.noOrderStack.isHidden = true
                    self.finishTableView.isHidden = false
                    self.totalOrdersCellDataSource = totalOrders
                    self.finishTableView.reloadData()
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
}
