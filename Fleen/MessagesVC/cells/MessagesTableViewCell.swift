//
//  MessagesTableViewCell.swift
//  Fleen
//
//  Created by Mina Eid on 23/03/2024.
//

import UIKit
import MOLH

class MessagesTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: MessagesTableViewCell.self)
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var trailingConstant: NSLayoutConstraint!
    @IBOutlet weak var leadingConstant: NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageLabel.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        checkLanguage()
    }

    func checkLanguage(){
        let isArabic = MOLHLanguage.currentAppleLanguage() == "ar"
        let alignment: NSTextAlignment = isArabic ? .right : .left
        
        messageLabel.textAlignment = alignment
    }
   
    
}
