//
//  ChangeProfileViewController.swift
//  Fleen
//
//  Created by Mina Eid on 11/03/2024.
//

import UIKit
import MOLH

class ChangeProfileViewController: UIViewController {
    

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopNameTextField: UITextField!
    @IBOutlet weak var commercialLabel: UILabel!
    @IBOutlet weak var commercialTextField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    var viewModel = ChangeProfileViewModel()
    var spinnerView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        saveBtn.isUserInteractionEnabled = true
        saveBtn.isEnabled = true
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    func setUI(){
        isEnable()
        setFonts()
        setNavigation()
        bindingViewModel()
        getProfilDetails()
        checkLanguage()
    }
    
    func checkLanguage(){
        let isArabic = MOLHLanguage.currentAppleLanguage() == "ar"
        let alignment: NSTextAlignment = isArabic ? .right : .left
        
        NameLabel.textAlignment = alignment
        nameTextField.textAlignment = alignment
        emailLabel.textAlignment = alignment
        emailTextField.textAlignment = alignment
        phoneLabel.textAlignment = alignment
        phoneNumberLabel.textAlignment = alignment
        shopNameLabel.textAlignment = alignment
        shopNameTextField.textAlignment = alignment
        commercialLabel.textAlignment = alignment
        commercialTextField.textAlignment = alignment
    }
    
    func setNavigation(){
        self.navigationItem.title = "Profile".localized
        self.tabBarController?.tabBar.isHidden = true
        let imageView = UIImageView(image: UIImage(named: "edit"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.addSubview(imageView)
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        let imageBarButtonItem = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = imageBarButtonItem
    }
    
    private func setFonts(){
        NameLabel.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        nameTextField.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        phoneLabel.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        phoneNumberLabel.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        emailLabel.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        emailTextField.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        shopNameLabel.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        shopNameTextField.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        commercialLabel.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        commercialTextField.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        
        NameLabel.text = "Name".localized
        nameTextField.placeholder = "Name".localized
        emailLabel.text = "Email".localized
        shopNameTextField.placeholder = "Shop name".localized
        commercialLabel.text = "Commercial Registration No".localized
        let SaveAttributedTitle = self.attributedTitle(for: "Save".localized, font: UIFont(name: "DMSans18pt-Regular", size: 16)!)
        saveBtn.setAttributedTitle(SaveAttributedTitle, for: .normal)
    }
    
    func attributedTitle(for text: String, font: UIFont) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        return NSAttributedString(string: text.localized, attributes: attributes)
    }
    
    
    @objc func editButtonTapped() {
        nameTextField.isUserInteractionEnabled = true
        emailTextField.isUserInteractionEnabled = true
        shopNameTextField.isUserInteractionEnabled = true
        commercialTextField.isUserInteractionEnabled = true
    }
    
    func isEnable(){
        nameTextField.isUserInteractionEnabled = false
        emailTextField.isUserInteractionEnabled = false
        shopNameTextField.isUserInteractionEnabled = false
        commercialTextField.isUserInteractionEnabled = false
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
    
    func getProfilDetails(){
        viewModel.getProfileData(viewController: self, api_response: { [weak self] data in
            self?.nameTextField.text = data?.data?.name
            self?.emailTextField.text = data?.data?.email
            self?.phoneNumberLabel.text = data?.data?.phone
            self?.shopNameTextField.text = data?.data?.shop_name
            self?.commercialTextField.text = data?.data?.commercial_registration_number
        })
    }
    
    func showLoadingIndicator(){
        spinnerView = displaySpinner(onView: self.view)
    }
    
    func hideLoadingIndicator() {
        if let sv = spinnerView{
            removeSpinner(spinner: sv)
        }
    }
    
    func validateAndShowAlert() {
        let name = nameTextField.text.orEmpty
        let email = emailTextField.text.orEmpty
        let shopName = shopNameTextField.text.orEmpty
        let comNumber = commercialTextField.text.orEmpty
        
        if !viewModel.validateFields(name: name, email: email, shopName: shopName, comNumber: comNumber) {
            showAlertError(title: "Invalid data!", message: viewModel.errorMessage)
        } else {
            
            
            viewModel.editProfileData(viewController: self, name: name, email: email, shop_name: shopName, commercial_registration_number: comNumber){
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    
    @IBAction func didTapSaveBtn(_ sender: Any) {
        print("dddd")
        validateAndShowAlert()
    }
    
    
    
}
