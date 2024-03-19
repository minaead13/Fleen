//
//  LanguageHelper.swift
//  Fleen
//
//  Created by Mina Eid on 26/02/2024.
//

import UIKit

class LanguageHelper {
    
    public static var language = LanguageHelper()
    
    func currentLanguage() -> String{
        if let firstLange = UserDefaults.standard.string(forKey: "language") {
            return firstLange.isEmpty ? "en" : firstLange
        } else {
            return "en"
        }
        
    }
    
    func setAppLanguage(lang: String){
        UserDefaults.standard.setValue(lang, forKey: "language")
    }
    
    func changeLanguage(lang:String,vc:UIViewController? = nil){
        if lang == currentLanguage(){
            vc?.dismiss(animated: true , completion: nil)
            return
        } else if lang == "ar"{
            UIView.appearance().semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        }else{
            UIView.appearance().semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
        }
        setAppLanguage(lang: lang)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let mainWindow = windowScene.windows.first {
                    let story = UIStoryboard(name: "Home", bundle: nil)
            mainWindow.rootViewController = story.instantiateViewController(withIdentifier: "TabBarViewController")
            mainWindow.makeKeyAndVisible()
            UIView.transition(with: mainWindow, duration: 0.55001, options: .transitionFlipFromLeft, animations: { () -> Void in
            }){
                (finished) -> Void in
            }
        }
    }

}
