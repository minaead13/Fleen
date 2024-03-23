//
//  notificationsDetailsViewController.swift
//  Fleen
//
//  Created by Mina Eid on 21/03/2024.
//

import UIKit
import MOLH

class notificationsDetailsViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
       
    }
    
    private func setUI(){
        self.tabBarController?.tabBar.isHidden = true
        setFonts()
        self.navigationItem.title = "Notifications".localized
        getCartCount()
        checkLanguage()
    }
    
    private func setFonts(){
        titleLabel.font = UIFont(name: "DMSans-Bold", size: 16)
        timeLabel.font = UIFont(name: "DMSans18pt-Regular", size: 12)
        detailsLabel.font = UIFont(name: "DMSans18pt-Regular", size: 14)
    }
    
    func checkLanguage(){
        let isArabic = MOLHLanguage.currentAppleLanguage() == "ar"
        let alignment: NSTextAlignment = isArabic ? .right : .left
        
        titleLabel.textAlignment = alignment
        detailsLabel.textAlignment = alignment
    }
    
    func getCartCount() {
        viewModel.getCartCount(viewController: self) { [weak self] data in
            guard let count = data?.data?.count else {
                self?.setupCartBadge(count: nil)
                return
            }
            
            self?.setupCartBadge(count: count)
        }
    }
    

    

}
