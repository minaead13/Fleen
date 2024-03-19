//
//  LocationTableViewCell.swift
//  Fleen
//
//  Created by Mina Eid on 02/02/2024.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var locImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    var id : Int?
    static let identifier = String(describing: LocationTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subTitleLabel.font = UIFont(name: "DMSans18pt-Regular", size: 10)
        titleLbl.font = UIFont(name: "DMSans-Bold", size: 13)
    }
    
    
}
