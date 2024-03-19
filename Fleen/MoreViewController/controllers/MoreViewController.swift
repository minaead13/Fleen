//
//  languageViewController.swift
//  Fleen
//
//  Created by Mina Eid on 23/01/2024.
//

import UIKit
import MOLH

class MoreViewController: UIViewController {
    
    @IBOutlet weak var moreTableView: UITableView!
    @IBOutlet weak var webSiteBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var twitterBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    
    var viewModel = MoreViewModel()
    let homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        getCartCount()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func getCartCount() {
        homeViewModel.getCartCount(viewController: self) { [weak self] data in
            guard let count = data?.data?.count else {
                self?.setupCartBadge(count: nil)
                return
            }
            
            self?.setupCartBadge(count: count)
        }
    }
    
    private func setTableView(){
        moreTableView.registerCell(cell: MoreTableViewCell.self)
    }
    
    func setUI(){
        self.tabBarController?.tabBar.isHidden = false
        setTableView()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.title = "More".localized
        webSiteBtn.setTitle("", for: .normal)
        notificationBtn.setTitle("", for: .normal)
        twitterBtn.setTitle("", for: .normal)
        facebookBtn.setTitle("", for: .normal)
    }
    
    private func changeLanguage(){
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        MOLH.reset()
    }

    
    func goTo(stringUrl : String){
        if let url = URL(string: stringUrl) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                if let webURL = URL(string: stringUrl) {
                    UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    
    @IBAction func didTapWebSiteBtn(_ sender: Any) {
        goTo(stringUrl: "https://www.facebook.com/")
    }
    
    @IBAction func didTapNotificationBtn(_ sender: Any) {
    }
    
    @IBAction func didTapTwitterBtn(_ sender: Any) {
    }
    
    @IBAction func didTapFaceBookBtn(_ sender: Any) {
    }
    
    
}

extension MoreViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoreTableViewCell.identifier, for: indexPath) as! MoreTableViewCell
        cell.titleLabel.font = UIFont(name: "DMSans18pt-Regular", size: 15)
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Profile".localized
            cell.moreImageView.image = UIImage(named: "profile")
        case 1:
            cell.titleLabel.text = "Locations".localized
            cell.moreImageView.image = UIImage(named: "locations")
        case 2:
            cell.titleLabel.text = "Payment methods".localized
            cell.moreImageView.image = UIImage(named: "wallet")
        case 3:
            cell.titleLabel.text = "Terms and Conditions".localized
            cell.moreImageView.image = UIImage(named: "terms")
        case 4:
            cell.titleLabel.text = "Privacy policy".localized
            cell.moreImageView.image = UIImage(named: "policy")
        case 5:
            cell.titleLabel.text = "Contact Us".localized
            cell.moreImageView.image = UIImage(named: "contact")
        case 6:
            cell.titleLabel.text = "Rate Us".localized
            cell.moreImageView.image = UIImage(named: "rate")
        case 7:
            cell.titleLabel.text = "Language".localized
            cell.moreImageView.image = UIImage(named: "website")
        case 8:
            cell.titleLabel.text = "Log out".localized
            cell.titleLabel.textColor = UIColor.placeHolder
            cell.moreImageView.image = UIImage(named: "logout")
       
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangeProfileViewController") as! ChangeProfileViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllLocationsViewController") as! AllLocationsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            print("")
        case 3:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactViewController") as! ContactViewController
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        case 6:
            print("")
        case 7:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangeLanguageViewController") as! ChangeLanguageViewController
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        case 8:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogOutViewController") as! LogOutViewController
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
       
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
    

