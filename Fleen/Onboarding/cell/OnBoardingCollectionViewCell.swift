//
//  OnBoardingCollectionViewCell.swift
//  Fleen
//
//  Created by Mina Eid on 14/01/2024.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var onboardingImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    
    func config(_ slide : OnboardingSlide){
        onboardingImageView.image = slide.image
        titleLabel.text = slide.title
        subTitleLbl.text = slide.subTitle
        titleLabel.font = UIFont(name: "DMSans-Bold", size: 28)
        subTitleLbl.font = UIFont(name: "DMSans18pt-Regular", size: 15)
    }
    
   
            
    

}
