//
//  FilterCollectionViewCell.swift
//  Fleen
//
//  Created by Mina Eid on 29/01/2024.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    static let identifier = String(describing: FilterCollectionViewCell.self)
    var viewModel: filterCellViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont(name: "DMSans18pt-Regular", size: 14)
    }
   
    func config(viewModel : filterCellViewModel ,  _ isSelected: Bool ){
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.title
        
        if isSelected {
            lineView.backgroundColor = UIColor.gold
        } else {
            lineView.backgroundColor = UIColor.placeHolder
        }
    }
}
