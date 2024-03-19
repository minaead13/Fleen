//
//  ViewController.swift
//  Fleen
//
//  Created by Mina Eid on 12/01/2024.
//

import UIKit

class MobileViewController: UIViewController {

    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var countryCodeTxt: UITextField!
    @IBOutlet weak var saudiNumberTextField: UITextField!
    @IBOutlet weak var ContinueBtn: UIButton!
    @IBOutlet weak var blockView: UIView!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var mobileStack: UIStackView!
    @IBOutlet weak var mobileInnerStack: UIStackView!
    @IBOutlet weak var codeStackView: UIStackView!
    
    var spinnerView: UIView?
    
    let totalNumOfMobile = 9
    let viewModel = MobileViewModel()
    var saudiNumber: String?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mobileInnerStack.semanticContentAttribute = .forceLeftToRight
        codeStackView.semanticContentAttribute = .forceLeftToRight
       
        setNavigation()
        
        mobileTextField.delegate = self
        setFonts()
        hideKeyboardWhenTappedAround()
        
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
    
    private func setNavigation(){
        navigationController?.navigationBar.tintColor = .black
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
    }
    
    private func setFonts(){
        TitleLbl.font = UIFont(name: "DMSans-Bold", size: 28)
        subTitleLbl.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        countryCodeTxt.font = UIFont(name: "DMSans-Bold", size: 24)
        saudiNumberTextField.font = UIFont(name: "DMSans-Bold", size: 24)
        ContinueBtn.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 16)
        TitleLbl.text = "Enter mobile number".localized
        subTitleLbl.text = "We will send a text message to log in".localized
        ContinueBtn.setTitle("Continue".localized, for: .normal)
    }
    
    @IBAction func didTapContinueBtn(_ sender: Any) {
        
        viewModel.checkMobileTxt(mobileTextField.text.orEmpty.replacedArabicDigitsWithEnglish)
        
        if viewModel.isMobileValid {
            bindingViewModel()
            
            saudiNumber = "966" + mobileTextField.text.orEmpty.replacedArabicDigitsWithEnglish
            
            viewModel.sendMobileNumber(viewController: self, phone: saudiNumber.orEmpty){
                self.navigateToNextViewController()
            }
            
        } else {
            
            self.showAlertError(title: "Error", message: "Please enter a valid number")
        }
    }
    
    
    private func navigateToNextViewController() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
        vc.phone = saudiNumber
        vc.loginCheck = viewModel.dataSource?.first_login
        mobileTextField.text = ""
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension MobileViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == mobileTextField {
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            let maxLength = totalNumOfMobile
            
            return newText.count <= maxLength
        }
            return true
    }
}

