//
//  TrackOrderStatusTableViewCell.swift
//  Fleen
//
//  Created by Mina Eid on 20/03/2024.
//

import UIKit
import MOLH

class TrackOrderStatusTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var dashLine: CustomDashedHorizontalLineView!
    
    static let identifier = String(describing: TrackOrderStatusTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        orderDateLabel.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        subTitleLabel.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        checkLanguage()
    }
    
    func checkLanguage(){
        let isArabic = MOLHLanguage.currentAppleLanguage() == "ar"
        let alignment: NSTextAlignment = isArabic ? .right : .left
        
        titleLabel.textAlignment = alignment
        orderDateLabel.textAlignment = alignment
        subTitleLabel.textAlignment = alignment
    }
//        drawDottedLine(start: CGPoint(x: dashLine.bounds.minX, y: dashLine.bounds.minY), end: CGPoint(x: dashLine.bounds.maxX, y: dashLine.bounds.minY), view: dashLine)
        
//        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 300, height: 20))
//        let image = renderer.image { context in
//            let dashedLineView = DashedLineView(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
//            dashedLineView.draw(dashedLineView.bounds)
//        }
    
    
//    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.strokeColor = UIColor.lightGray.cgColor
//        shapeLayer.lineWidth = 1
//        shapeLayer.lineDashPattern = [4, 20]
//
//        let path = CGMutablePath()
//        path.addLines(between: [p0, p1])
//        shapeLayer.path = path
//        view.layer.addSublayer(shapeLayer)
//    }
   
}



class CustomDashedHorizontalLineView: UIView {
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0
//    @IBInspectable var cornerRadius: CGFloat = 0 {
//        didSet {
//            layer.cornerRadius = cornerRadius
//            layer.masksToBounds = cornerRadius > 0
//        }
//    }

    var dashBorder: CAShapeLayer?

    override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        
        // Draw horizontal line
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX, y: bounds.midY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
        
        dashBorder.path = path.cgPath
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}
