//
//  TabBarViewController.swift
//  Fleen
//
//  Created by Mina Eid on 31/01/2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setTabBar()
    }
    
    private func setTabBar(){
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 1, alpha: 1)
        
        let tabBarColor = UIColor(red: CGFloat(35) / 255.0,green: CGFloat(170) / 255.0,blue: CGFloat(73) / 255.0, alpha: 1.0)
        UITabBar.appearance().tintColor = tabBarColor
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        if #available(iOS 15.0, *) {
#if swift(>=5.5) // Only run on Xcode version >= 13 (Swift 5.5 was shipped first with Xcode 13).
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
#endif
        } else {
            // Fallback for earlier versions
            UITabBar.appearance().standardAppearance = tabBarAppearance
        }
        
        if let tabs = self.tabBar.items {
            tabs[0].title = "Orders".localized
            tabs[1].title = "Home".localized
            tabs[2].title = "More".localized
        }
        
        self.selectedIndex = 1
    }
}

   


