//
//  PrivacyPolicyViewController.swift
//  Fleen
//
//  Created by Mina Eid on 05/03/2024.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    
    @IBOutlet weak var privacyTextView: UITextView!
    
    let homeViewModel = HomeViewModel()
    let viewModel = TermsViewModel()
    var spinnerView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "Privacy policy".localized
        bindingViewModel()
        getPrivacyData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCartCount()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }

    
    func getCartCount() {
        homeViewModel.getCartCount(viewController: self) { [weak self] data in
            guard let count = data?.data?.count else {
                self?.setupCartBadge(count: nil)
                return
            }
            self?.setupCartBadge(count: count)
        }
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
    }
    
    func getPrivacyData(){
        viewModel.getRules(viewController: self, endoPoint: "privacy") { [weak self] privacy in
            self?.privacyTextView.text = privacy?.data?.terms
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
