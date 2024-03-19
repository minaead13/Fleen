//
//  AllLocationsViewController.swift
//  Fleen
//
//  Created by Mina Eid on 11/03/2024.
//

import UIKit

class AllLocationsViewController: UIViewController , DeleteLocationViewControllerDelegate , LocationViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    
    let viewModel = CartViewModel()
    var locationArray : [AddressModel]?
    var spinnerView: UIView?
    let homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        tableView.registerCell(cell: AllLocationsTableViewCell.self)
        bindingViewModel()
        
        bindingHomeViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        getAddress()
        getCartCount()
    }
    
    
    private func setUI(){
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "Locations".localized
        let addAttributedTitle = self.attributedTitle(for: "Add Location".localized, font: UIFont(name: "DMSans18pt-Regular", size: 16)!)
        addBtn.setAttributedTitle(addAttributedTitle, for: .normal)
    }
    
    func attributedTitle(for text: String, font: UIFont) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        return NSAttributedString(string: text.localized, attributes: attributes)
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

    func bindingHomeViewModel(){
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
    
    func getAddress(){
        viewModel.getAddresses(viewController: self){ [weak self] data in
            self?.locationArray = data?.data
            self?.tableView.reloadData()
            
        }
    }
    
    func showLoadingIndicator(){
        spinnerView = displaySpinner(onView: self.view)
    }
    
    func hideLoadingIndicator() {
        if let sv = spinnerView{
            removeSpinner(spinner: sv)
        }
    }
    
    func locationViewControllerDidDeleteLocation() {
        getAddress()
    }
    
    func locationViewControllerDidSendLocation() {
        getAddress()
    }
    

    @IBAction func didTapAddBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddLocationViewController") as! AddLocationViewController
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    

}

extension AllLocationsViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllLocationsTableViewCell.identifier, for: indexPath) as! AllLocationsTableViewCell

        if let address = locationArray?[indexPath.row] {
            cell.config(address: address)
        }
        
        cell.handleAction = { [weak self] address in
            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "DeleteLocationViewController") as! DeleteLocationViewController
            vc.addressData = address
            vc.delegate = self
            vc.modalPresentationStyle = .overFullScreen
            self?.present(vc, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
}
