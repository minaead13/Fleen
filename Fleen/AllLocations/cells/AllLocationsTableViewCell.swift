//
//  AllLocationsTableViewCell.swift
//  Fleen
//
//  Created by Mina Eid on 11/03/2024.
//

import UIKit

class AllLocationsTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: AllLocationsTableViewCell.self)
    
    @IBOutlet weak var mapImage: UIImageView!
    @IBOutlet weak var detailesLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var handleAction: ((AddressModel) -> Void)?
    var addressData : AddressModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deleteBtn.setTitle("", for: .normal)
        titleLabel.font =  UIFont(name: "DMSans-Bold", size: 16)
        detailesLabel.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        phoneLabel.font = UIFont(name: "DMSans18pt-Regular", size: 14)
    }
    
    func config(address : AddressModel){
        addressData = address
        titleLabel?.text = address.type
        detailesLabel?.text = address.default_address
        phoneLabel.text = address.address
    }

   
    
    @IBAction func didTapDeleteBtn(_ sender: Any) {
        if let address = addressData {
            handleAction?(address)
        }
        
    }
    
    
    
}
