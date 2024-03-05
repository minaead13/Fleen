//
//  TableViewCell.swift
//  Fleen
//
//  Created by Mina Eid on 04/03/2024.
//

import UIKit

class MoreTableViewCell: UITableViewCell {

    @IBOutlet weak var moreImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = String(describing: MoreTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont(name: "DMSans18pt-Regular", size: 15)
    }

    
    
}
