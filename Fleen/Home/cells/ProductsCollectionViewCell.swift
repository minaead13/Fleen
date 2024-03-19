//
//  ProductsCollectionViewCell.swift
//  Fleen
//
//  Created by Mina Eid on 29/01/2024.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    static let identifier = String(describing: ProductsCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont(name: "DMSans-Bold", size: 14)
        subTitleLabel.font = UIFont(name: "DMSans18pt-Regular", size: 12)
    }
    
    func config(viewModel : productsCellViewModel ){
        self.titleLabel.text = viewModel.title
      //  self.subTitleLabel.text = viewModel.subTitle
        self.productImageView.kf.setImage(with: URL(string: viewModel.image.orEmpty))
    }

    override func prepareForReuse() {
        super.prepareForReuse()
      //  productImageView.image = nil
    }
}
