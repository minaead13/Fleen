//
//  SceneDelegate.swift
//  Fleen
//
//  Created by Mina Eid on 12/01/2024.
//

import UIKit
import MOLH
class SceneDelegate: UIResponder, UIWindowSceneDelegate , MOLHResetable {
    
    var window: UIWindow?
    
    func reset() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let rootViewController = sceneDelegate.window?.rootViewController
            let story = UIStoryboard(name: "Home", bundle: nil)
            rootViewController?.window?.rootViewController = story.instantiateViewController(withIdentifier: "TabBarViewController")
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
//        guard let scene = (scene as? UIWindowScene) else { return }
//        
//        let storyboard = UIStoryboard(name: "Home", bundle: nil)
//
//        let loginViewController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
//        
//        window?.rootViewController = loginViewController
//        window?.makeKeyAndVisible()
        
//        window = UIWindow(windowScene: scene)
//        var controller: UIViewController!
        
//        if UserDefaults.standard.hasOnboarded{
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            controller = storyboard.instantiateViewController(withIdentifier: "mobileVC") as! UINavigationController
//            
//        }else {
//            controller = OnboardingViewController.instantiate()
//            
//        }
//        window?.rootViewController = controller
//        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
       
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

