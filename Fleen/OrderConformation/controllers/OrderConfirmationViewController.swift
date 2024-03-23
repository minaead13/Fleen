//
//  OrderConfirmationViewController.swift
//  Fleen
//
//  Created by Mina Eid on 18/03/2024.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    
    @IBOutlet weak var resendLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var dismissBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI(){
        setData()
        setFonts()
    }
    
    private func setData(){
        //self.tabBarController?.tabBar.isHidden = true
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        resendLabel.text = "Resend the request".localized
        subTitleLabel.text = "When you resend the request, this may result in an increase or decrease in the prices of the selected products".localized
        okBtn.setTitle("Ok".localized, for: .normal)
        dismissBtn.setTitle("", for: .normal)
    }
    
    private func setFonts(){
        resendLabel.font = UIFont(name: "DMSans-Bold", size: 16)
        subTitleLabel.font = UIFont(name: "DMSans18pt-Regular", size: 16)
    
        let okAttributedTitle = self.attributedTitle(for: "Ok".localized, font: UIFont(name: "DMSans18pt-Regular", size: 16)!)
        okBtn.setAttributedTitle(okAttributedTitle, for: .normal)
    }
    
    func attributedTitle(for text: String, font: UIFont) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        return NSAttributedString(string: text.localized, attributes: attributes)
    }
   
    
    

    @IBAction func didTapOkBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func didTapDismissBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}
