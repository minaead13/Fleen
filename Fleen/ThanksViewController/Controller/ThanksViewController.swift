//
//  ThanksViewController.swift
//  Fleen
//
//  Created by Mina Eid on 12/02/2024.
//

import UIKit

class ThanksViewController: UIViewController {

    @IBOutlet weak var requestLabel: UILabel!
    @IBOutlet weak var thanksLabel: UILabel!
    @IBOutlet weak var ThanksBtn: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI(){
        requestLabel.text = "request sent".localized
        thanksLabel.text = "Thank you for using Fleen to complete your order. Your order is now in our hands".localized
        ThanksBtn.setTitle("thanks".localized, for: .normal)
        
        requestLabel.font = UIFont(name: "DMSans-Bold", size: 28)
        thanksLabel.font = UIFont(name: "DMSans18pt-Regular", size: 15)
        ThanksBtn.titleLabel?.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
    }

    @IBAction func didTapThanksBtn(_ sender: Any) {
        if let firstViewController = navigationController?.viewControllers.first {
            navigationController?.popToViewController(firstViewController, animated: true)
        }
    }
}
