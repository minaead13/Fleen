//
//  TableViewCell.swift
//  Fleen
//
//  Created by Mina Eid on 04/03/2024.
//

import UIKit
import MOLH

class MoreTableViewCell: UITableViewCell {

    @IBOutlet weak var moreImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = String(describing: MoreTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkLanguage()
        titleLabel.font = UIFont(name: "DMSans18pt-Regular", size: 15)
    }
    
    func checkLanguage(){
        let isArabic = MOLHLanguage.currentAppleLanguage() == "ar"
        let alignment: NSTextAlignment = isArabic ? .right : .left
        
        titleLabel.textAlignment = alignment
        
    }

    
    
}
