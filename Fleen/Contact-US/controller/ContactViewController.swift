//
//  ContactViewController.swift
//  Fleen
//
//  Created by Mina Eid on 06/03/2024.
//

import UIKit
import MOLH

class ContactViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var whatsImage: UIImageView!
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var dismissBtn: UIButton!
    
    let viewModel = ContactViewModel()
    var spinnerView: UIView?
    var whatsNumber : String?
    var email : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingViewModel()
        getContactData()
        addTapGesture()
        setUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
   
    
    func addTapGesture(){
       
        let whatsTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapWhatsImage))
        self.whatsImage.addGestureRecognizer(whatsTapGesture)
        
        let emailTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapEmailImage))
        self.emailImage.addGestureRecognizer(emailTapGesture)
    }
    
    private func setUI(){
        checkLanguage()
        self.tabBarController?.tabBar.isHidden = true
        dismissBtn.setTitle("", for: .normal)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        contactLabel.font = UIFont(name: "DMSans-Bold", size: 18)
        contactLabel.text = "Contact us".localized
        
        mobileLabel.font = UIFont(name: "DMSans18pt-Regular", size: 18)
        locationLabel.font = UIFont(name: "DMSans18pt-Regular", size: 18)
        
    }
    
    func checkLanguage(){
        let isArabic = MOLHLanguage.currentAppleLanguage() == "ar"
        let alignment: NSTextAlignment = isArabic ? .right : .left
        
        mobileLabel.textAlignment = alignment
        locationLabel.textAlignment = alignment
        contactLabel.textAlignment = alignment
    }
    
    @objc func didTapEmailImage(){
        let urlString = "mailto:\(self.email.orEmpty)"
        if let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlStringEncoded) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc func didTapWhatsImage(){
        if let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(whatsNumber.orEmpty)") {
            if UIApplication.shared.canOpenURL(whatsappURL) {
                UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
            } else {
                self.showAlertError(title: "Error".localized, message: "WhatsApp is not installed on this device".localized)
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
    
    func getContactData(){
        viewModel.getContactData(viewController: self) { [weak self] contactData in
            self?.locationLabel.text = contactData?.data?.address
            self?.mobileLabel.text = contactData?.data?.phone
            self?.whatsNumber = contactData?.data?.whatsapp
            self?.email = contactData?.data?.email
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

    @IBAction func didTapDismissBtn(_ sender: Any) {
        self.dismiss(animated: true )
    }
    

}
