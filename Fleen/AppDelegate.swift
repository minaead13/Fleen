//
//  AppDelegate.swift
//  Fleen
//
//  Created by Mina Eid on 12/01/2024.
//

import UIKit
import IQKeyboardManagerSwift
import MOLH

@main
class AppDelegate: UIResponder, UIApplicationDelegate  {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        Localizer.DoTheSwizzling()
//        if LanguageHelper.language.currentLanguage() == "ar" {
//           UIView.appearance().semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
//        } else {
//            UIView.appearance().semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
//        }
        
        MOLH.shared.activate(true)
        
//        let deviceLanguage = Locale.preferredLanguages.first ?? "en"
//        setAppLanguage(languageCode: deviceLanguage)

       
        IQKeyboardManager.shared.enable = true
        
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
            // navigationBarAppearance.backgroundColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 1, alpha: 1)
            navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            UINavigationBar.appearance().tintColor = UIColor.tintColor
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
        
        
//            let tabBarAppearance = UITabBarAppearance()
//            tabBarAppearance.configureWithTransparentBackground()
//            tabBarAppearance.backgroundColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 1, alpha: 1)
//            UITabBar.appearance().tintColor = #colorLiteral(red: 0.006245330907, green: 0.4581464529, blue: 0.8879924417, alpha: 1)
//            UITabBar.appearance().standardAppearance = tabBarAppearance
//            #if swift(>=5.5) // Only run on Xcode version >= 13 (Swift 5.5 was shipped first with Xcode 13).
//            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
//            #endif
        
//        
//        let mainStoryboard = UIStoryboard(name: "Home", bundle: nil)
//            
//        if let initialViewController = mainStoryboard.instantiateInitialViewController() {
//            window = UIWindow(frame: UIScreen.main.bounds)
//            window?.rootViewController = initialViewController
//            window?.makeKeyAndVisible()
//        }
        
        
        return true
    }
    
    func setAppLanguage(languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

//let rootViewController: UIWindow = UIApplication.shared.windows.first!


//func reset() {
////        let storyboard = UIStoryboard(name: "Home", bundle: nil)
////        let nav = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
////
////        let scene = UIApplication.shared.connectedScenes.first
////        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate){
////            sd.window!.rootViewController = nav
////        }
//    
//    let rootViewController: UIWindow = ((UIApplication.shared.delegate?.window)!)!
//    //let rootViewController: UIWindow = UIApplication.shared.windows.first!
//    let story = UIStoryboard(name: "Home", bundle: nil)
//    rootViewController.rootViewController = story.instantiateViewController(withIdentifier: "TabBarViewController")
//}
