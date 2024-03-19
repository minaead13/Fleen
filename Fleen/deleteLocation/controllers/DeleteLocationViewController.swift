//
//  DeleteLocationViewController.swift
//  Fleen
//
//  Created by Mina Eid on 11/03/2024.
//

import UIKit

protocol DeleteLocationViewControllerDelegate: AnyObject {
    func locationViewControllerDidDeleteLocation()
}

class DeleteLocationViewController: UIViewController {
    
    @IBOutlet weak var askLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var addressDetailsLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var dismissBtn: UIButton!
    
    
    weak var delegate: DeleteLocationViewControllerDelegate?
    var addressData : AddressModel?
    var viewModel = DeleteViewModel()
    var spinnerView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }

    
    private func setUI(){
        self.tabBarController?.tabBar.isHidden = true
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        dismissBtn.setTitle("", for: .normal)
        askLabel.text = "Do you want to delete the address?".localized
        askLabel.font =  UIFont(name: "DMSans-Bold", size: 18)
        homeLabel.font =  UIFont(name: "DMSans-Bold", size: 16)
        addressDetailsLabel.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        phoneLabel.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        setData()
        let noAttributedTitle = self.attributedTitle(for: "No".localized, font: UIFont(name: "DMSans18pt-Regular", size: 16)!)
        noBtn.setAttributedTitle(noAttributedTitle, for: .normal)
        
        let logOutAttributedTitle = self.attributedTitle(for: "Delete".localized, font: UIFont(name: "DMSans18pt-Regular", size: 16)!)
        deleteBtn.setAttributedTitle(logOutAttributedTitle, for: .normal)
    }
    
    func attributedTitle(for text: String, font: UIFont) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        return NSAttributedString(string: text.localized, attributes: attributes)
    }
    
    private func setData(){
        homeLabel?.text = addressData?.type
        addressDetailsLabel?.text = addressData?.default_address
        phoneLabel.text = addressData?.address
    }
    
    func sentRequest(){
        viewModel.deleteLocation(viewController: self, id: addressData?.id ?? 0 ,successCallback: { [weak self] in
            guard let self = self else { return }
            self.delegate?.locationViewControllerDidDeleteLocation()
            self.dismiss(animated: true)
        })
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
    
    func showLoadingIndicator() {
        spinnerView = displaySpinner(onView: self.view)
    }
    
    func hideLoadingIndicator() {
        if let sv = spinnerView{
            removeSpinner(spinner: sv)
        }
    }
    
    
    @IBAction func didTapNoBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

    @IBAction func didTapDeleteBtn(_ sender: Any) {
        sentRequest()
    }
    
    @IBAction func didTapDismissBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}
