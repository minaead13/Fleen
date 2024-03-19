//
//  TimeCollectionViewCell.swift
//  Fleen
//
//  Created by Mina Eid on 30/01/2024.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentStack: UIStackView!
    @IBOutlet weak var upperView: UIView!
    
    var id : Int?
    static let identifier = String(describing: TimeCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectBtn.setTitle("", for: .normal)
        timeLabel.font = UIFont(name: "DMSans18pt-Regular", size: 14)
    }
    
    func configureTimeCell(filterTitle: Time, _ isSelected: Bool ) {
        timeLabel.text = filterTitle.time
        
        if isSelected {
            selectBtn.setImage(UIImage(named: "circle-on"), for: .normal)
        } else {
            selectBtn.setImage(UIImage(named: "circle-off"), for: .normal)
        }
    }

}
