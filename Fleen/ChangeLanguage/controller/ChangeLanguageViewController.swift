//
//  ChangeLanguageViewController.swift
//  Fleen
//
//  Created by Mina Eid on 10/03/2024.
//

import UIKit
import MOLH
class ChangeLanguageViewController: UIViewController {
    
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var arabicBtn: UIButton!
    @IBOutlet weak var englishBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    func setUI(){
        self.tabBarController?.tabBar.isHidden = true
        dismissBtn.setTitle("", for: .normal)
        languageLabel.font = UIFont(name: "DMSans-Bold", size: 18)
        languageLabel.text = "Language".localized
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        let arabicAttributedTitle = self.attributedTitle(for: "Arabic".localized, font: UIFont(name: "DMSans18pt-Regular", size: 16)!)
        arabicBtn.setAttributedTitle(arabicAttributedTitle, for: .normal)
        
        let englishAttributedTitle = self.attributedTitle(for: "English".localized, font: UIFont(name: "DMSans18pt-Regular", size: 16)!)
        englishBtn.setAttributedTitle(englishAttributedTitle, for: .normal)
    }
    
    func attributedTitle(for text: String, font: UIFont) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        return NSAttributedString(string: text.localized, attributes: attributes)
    }

    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func didTapArabicBtn(_ sender: Any) {
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            self.dismiss(animated: true)
        } else if MOLHLanguage.currentAppleLanguage() == "en" {
            MOLH.setLanguageTo( "ar")
            MOLH.reset()
        }
    }
   
    
    @IBAction func didTapEnglishBtn(_ sender: Any) {
        if MOLHLanguage.currentAppleLanguage() == "en" {
            self.dismiss(animated: true)
        } else if MOLHLanguage.currentAppleLanguage() == "ar" {
            MOLH.setLanguageTo( "en")
            MOLH.reset()
        }
    }
    

}
