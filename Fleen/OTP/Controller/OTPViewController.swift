//
//  OTPViewController.swift
//  Fleen
//
//  Created by Mina Eid on 15/01/2024.
//

import UIKit
import NVActivityIndicatorView
import MOLH

class OTPViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var OTP1: UITextField!
    @IBOutlet weak var OTP2: UITextField!
    @IBOutlet weak var OTP3: UITextField!
    @IBOutlet weak var OTP4: UITextField!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var ResendBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var resendStack: UIStackView!
    @IBOutlet weak var otpStack: UIStackView!
    @IBOutlet weak var otpView: UIView!
    
    var timerViewModel = TimerViewModel()
    var viewModel = MobileViewModel()
    var phone: String?
    var loginCheck : Bool?
    var spinnerView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otpStack.semanticContentAttribute = .forceLeftToRight
        
        bindingViewModel()
        setFonts()
        setNavigation()
        setupTextFieldDelegates()
        hideKeyboardWhenTappedAround()
        setupBindings()
        checkLanguage()
    }
    
    func checkLanguage(){
        let isArabic = MOLHLanguage.currentAppleLanguage() == "ar"
        let alignment: NSTextAlignment = isArabic ? .right : .left
        
        messageLbl.textAlignment = alignment
    }
    
    private func setNavigation(){
        navigationController?.navigationBar.tintColor = .black
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
    }
    
    func bindingViewModel(){
        timerViewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self,
                  let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self.showLoadingIndicator()
                } else {
                    print("hidddddeeee")
                    self.hideLoadingIndicator()
                }
            }
        }
    }
    
    func bindingMobileViewModel(){
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
        if let sv = spinnerView {
            removeSpinner(spinner: sv)
        }
    }

    
    func setupBindings() {
        timerViewModel.delegate = self
        //  ResendBtn.isEnabled = false
        resendStack.isHidden = true
    }
    
    private func setupTextFieldDelegates(){
        OTP1.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        OTP2.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        OTP3.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        OTP4.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        OTP1.tag = 1
        OTP2.tag = 2
        OTP3.tag = 3
        OTP4.tag = 4

        OTP1.delegate = self
        OTP2.delegate = self
        OTP3.delegate = self
        OTP4.delegate = self
    }
    
    
    @objc private func textDidChange(textfield: UITextField) {
        let text = textfield.text

        if text?.count == 1 {
            let nextTag = textfield.tag + 1
            if let nextResponder = textfield.superview?.viewWithTag(nextTag) as? UITextField {
                nextResponder.becomeFirstResponder()
            }
        } else if text?.count == 0 {
            let previousTag = textfield.tag - 1
            if let previousResponder = textfield.superview?.viewWithTag(previousTag) as? UITextField {
                previousResponder.becomeFirstResponder()
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        let allowedCharacters = CharacterSet(charactersIn: "0123456789")
        let characterSet = CharacterSet(charactersIn: newText)
        return allowedCharacters.isSuperset(of: characterSet) && newText.count <= 1
    }
    

    private func setFonts(){
        
        titleLbl.font = UIFont(name: "DMSans-Bold", size: 28)
        subTitleLbl.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        timerLbl.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        messageLbl.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        ResendBtn.titleLabel?.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        continueBtn.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 16)
        
        titleLbl.text = "Confirm mobile number".localized
        subTitleLbl.text = "Enter the OTP code".localized
        messageLbl.text = "Did the message not arrive?".localized
        continueBtn.setTitle("Confirm".localized, for: .normal)
        ResendBtn.setTitle("Resend it".localized, for: .normal)
        
    }
    
    
    @IBAction func DidTapResend(_ sender: Any) {
        timerViewModel.restartTimer()
        bindingMobileViewModel()
        viewModel.sendMobileNumber(viewController: self, phone: phone.orEmpty)
        
    }
    
    @IBAction func didTapContinueBtn(_ sender: Any) {
                
        let otpInputs = [OTP1, OTP2, OTP3, OTP4].map { $0.text ?? "" }
            
        for otp in otpInputs {
            timerViewModel.checkOTP(otp)
        }
        
        if timerViewModel.isValidOTP {
            bindingViewModel()
           
            let totalOtp = otpInputs.joined().replacedArabicDigitsWithEnglish
          
            timerViewModel.sendMobileNumber(viewController: self, phone: phone.orEmpty, code: totalOtp){
                self.navigateToNextViewController()
            }
            
        } else {
           
            self.showAlertError(title: "Error".localized, message: "Please enter a valid OTP")
        }
    }
    
    private func navigateToNextViewController() {
        if loginCheck == true {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
    
    


extension OTPViewController: TimerViewModelDelegate {
    func timerDidUpdate(timeString: String) {
        timerLbl.text = timeString
    }
    
    func timerDidFinish(buttonEnabled: Bool) {
        //ResendBtn.isEnabled = buttonEnabled
        resendStack.isHidden = !buttonEnabled
    }
}


    
