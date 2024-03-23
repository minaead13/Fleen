//
//  NotificationsTableViewCell.swift
//  Fleen
//
//  Created by Mina Eid on 21/03/2024.
//

import UIKit
import MOLH

class NotificationsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    static let identifier = String(describing: NotificationsTableViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        dateLabel.font = UIFont(name: "DMSans18pt-Regular", size: 12)
        subTitleLabel.font = UIFont(name: "DMSans18pt-Regular", size: 12)
        checkLanguage()
    }
    
    func checkLanguage(){
        let isArabic = MOLHLanguage.currentAppleLanguage() == "ar"
        let alignment: NSTextAlignment = isArabic ? .right : .left
        
        titleLabel.textAlignment = alignment
        subTitleLabel.textAlignment = alignment
    }

    
    
}
