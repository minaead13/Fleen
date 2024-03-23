//
//  TrachOrderStatusViewController.swift
//  Fleen
//
//  Created by Mina Eid on 20/03/2024.
//

import UIKit
import MOLH

class TrachOrderStatusViewController: UIViewController {

    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewOrderBtn: UIButton!
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
       
    }
    
    private func setUI(){
        self.tabBarController?.tabBar.isHidden = true
        setFonts()
        tableView.registerCell(cell: TrackOrderStatusTableViewCell.self)
        self.navigationItem.title = "Track order status".localized
        getCartCount()
        checkLanguage()
    }
    
    private func setFonts(){
        orderNumberLabel.font = UIFont(name: "DMSans-Bold", size: 16)
        quantityLabel.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        dateLabel.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        let viewAttributedTitle = self.attributedTitle(for: "View the order".localized, font: UIFont(name: "DMSans18pt-Regular", size: 16)!)
        viewOrderBtn.setAttributedTitle(viewAttributedTitle, for: .normal)
    }
    
    func checkLanguage(){
        let isArabic = MOLHLanguage.currentAppleLanguage() == "ar"
        let alignment: NSTextAlignment = isArabic ? .right : .left
        
        orderNumberLabel.textAlignment = alignment
        quantityLabel.textAlignment = alignment
        dateLabel.textAlignment = alignment
    }
    
    func attributedTitle(for text: String, font: UIFont) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        return NSAttributedString(string: text.localized, attributes: attributes)
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
    
    
    @IBAction func didTapViewOrderBtn(_ sender: Any) {
        
    }
}

extension TrachOrderStatusViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackOrderStatusTableViewCell.identifier, for: indexPath) as! TrackOrderStatusTableViewCell
        if indexPath.row == 3 {
            cell.dashLine.isHidden = true
        }
        return cell
    }
    
    
}
