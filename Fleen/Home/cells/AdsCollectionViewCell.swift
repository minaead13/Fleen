//
//  AdsCollectionViewCell.swift
//  Fleen
//
//  Created by Mina Eid on 29/01/2024.
//

import UIKit
import Kingfisher
class AdsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var adsImageView: UIImageView!
    
    static let identifier = String(describing: AdsCollectionViewCell.self)
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
       // adsImageView.image = nil
    }

    func config(viewModel : addsCellViewModel){
        print("addddddddsssss\(viewModel.image)")
        self.adsImageView.kf.setImage(with: URL(string: viewModel.image.orEmpty))
    }
}
