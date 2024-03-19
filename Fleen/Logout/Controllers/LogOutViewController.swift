//
//  LogOutViewController.swift
//  Fleen
//
//  Created by Mina Eid on 10/03/2024.
//

import UIKit

class LogOutViewController: UIViewController {

    @IBOutlet weak var logoutLbl: UILabel!
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var logOutBtn: UIButton!
    
    
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
        logoutLbl.font = UIFont(name: "DMSans-Bold", size: 18)
        logoutLbl.text = "Do you want to log out?".localized
        let noAttributedTitle = self.attributedTitle(for: "No".localized, font: UIFont(name: "DMSans18pt-Regular", size: 16)!)
        noBtn.setAttributedTitle(noAttributedTitle, for: .normal)
        
        let logOutAttributedTitle = self.attributedTitle(for: "Log out".localized, font: UIFont(name: "DMSans18pt-Regular", size: 16)!)
        logOutBtn.setAttributedTitle(logOutAttributedTitle, for: .normal)
    }
    
    func attributedTitle(for text: String, font: UIFont) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        return NSAttributedString(string: text.localized, attributes: attributes)
    }
    
    
    @IBAction func didTapDismissBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    
    @IBAction func didTapNoBtn(_ sender: Any) {
        self.dismiss(animated: true)

    }
    
    
    @IBAction func didTapLogOutBtn(_ sender: Any) {
    }
    
}
