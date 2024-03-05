//
//  languageViewController.swift
//  Fleen
//
//  Created by Mina Eid on 23/01/2024.
//

import UIKit
import MOLH

class MoreViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func didTap(_ sender: Any) {
        
//        if LanguageHelper.language.currentLanguage() == "en"{
//            LanguageHelper.language.changeLanguage(lang: "ar")
//        }else{
//            LanguageHelper.language.changeLanguage(lang: "en")
//        }
        
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        MOLH.reset()
        
        
        
        //1
        //        Language.setAppLanguage(lang: "en")
        //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        //        vc.selectedIndex = 1
        //        AppHelper.changeWindowRoot(vc: vc,options: .transitionFlipFromRight)
        
        
        //2
        
        //3
        //
        //                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        //
        //                if UIApplication.shared.canOpenURL(settingsUrl) {
        //                    UIApplication.shared.open(settingsUrl, options: [:]) { _ in
        //
        //
        //                    }
        //                }
        
    }
    
    
    func setAppLanguage(languageCode: String) {
        // Set the app's language
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    
    
    
    
    //        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
    //       // self.changeLanguage(to: MOLHLanguage.currentAppleLanguage())
    //        MOLH.reset()
    //        UserDefaults.standard.set(MOLHLanguage.currentAppleLanguage(), forKey: "language")
    //        print(UserDefaults.standard.string(forKey: "language"))
}

struct AppHelper {
    
    static func changeWindowRoot(vc: UIViewController, options: UIView.AnimationOptions = .transitionCrossDissolve) {
        UIApplication.shared.windows.first?.rootViewController = vc
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        guard let window = window else {return}
        UIView.transition(with: window, duration: 0.3, options: options, animations: nil, completion: nil)
    }
    
}
    
struct Language {
    
    enum Languages {
        static let en = "en"
        static let ar = "ar"
    }
    
    static func currentLanguage() -> String {
        let languages = UserDefaults.standard.object(forKey: "AppleLanguages") as! NSArray
        let firstLanguage = languages.firstObject as! String
        return firstLanguage
    }
    static func setAppLanguage(lang: String) {
        UserDefaults.standard.set([lang, currentLanguage()], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        Language.handleViewDirection()

    }
    
    static func tempSetAppLanguage(lang: String){
        UserDefaults.standard.set([lang, currentLanguage()], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        Language.handleViewDirection()
    }
    
    static func apiLanguage() -> String {
        return self.currentLanguage().contains(Languages.ar) ? Languages.ar : Languages.en
    }
    static func isRTL() -> Bool {
        return self.currentLanguage().contains(Languages.ar) ? true : false
    }
    
    static func handleViewDirection() {
        UIPageControl.appearance().semanticContentAttribute = isRTL() ? .forceRightToLeft : .forceLeftToRight
        UIStackView.appearance().semanticContentAttribute = isRTL() ? .forceRightToLeft : .forceLeftToRight
        UISwitch.appearance().semanticContentAttribute = isRTL() ? .forceRightToLeft : .forceLeftToRight
        UIView.appearance().semanticContentAttribute = isRTL() ? .forceRightToLeft : .forceLeftToRight
        UICollectionView.appearance().semanticContentAttribute = isRTL() ? .forceRightToLeft : .forceLeftToRight
        UITextField.appearance().textAlignment = isRTL() ? .right : .left
        UITextField.appearance().textAlignment = .center
        UILabel.appearance().semanticContentAttribute = isRTL() ? .forceRightToLeft : .forceLeftToRight
        UITextView.appearance().semanticContentAttribute = isRTL() ? .forceRightToLeft : .forceLeftToRight
        UITextField.appearance().semanticContentAttribute = isRTL() ? .forceRightToLeft : .forceLeftToRight
    }
    
}
    

