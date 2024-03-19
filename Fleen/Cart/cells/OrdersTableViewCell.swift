//
//  OrdersTableViewCell.swift
//  Fleen
//
//  Created by Mina Eid on 30/01/2024.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var orderTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var increaseBtn: UIButton!
    @IBOutlet weak var decreaseBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    @IBOutlet weak var contentStack: UIStackView!
    
    static let identifier = String(describing: OrdersTableViewCell.self)
    var updateAction: ((Int, Int) -> Void)?
    var deleteAction: ((Int, Int) -> Void)?
    var id : Int?
    var productID : Int?
    var count = 0 {
        didSet {
           // countLabel.text = "\(count)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //contentStack.semanticContentAttribute = .forceRightToLeft
        increaseBtn.setTitle("", for: .normal)
        decreaseBtn.setTitle("", for: .normal)
        deleteBtn.setTitle("", for: .normal)
        orderTitleLabel.font = UIFont(name: "DMSans-Bold", size: 14)
        priceLabel.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        unitLabel.font = UIFont(name: "DMSans18pt-Regular", size: 12)
        countLabel.font = UIFont(name: "DMSans-Bold", size: 18)
    }
    
    func config(cart : CartCellViewModel){
        self.id = cart.id
        if let productID = Int(cart.productID.orEmpty) {
            self.productID = productID
        } else {
            print("Invalid product ID: \(cart.productID)")
        }
        self.orderTitleLabel.text = cart.name
        self.priceLabel.text = cart.price
        self.count = cart.qty ?? 0
        self.countLabel.text = "\(cart.qty.orEmpty)"
        self.unitLabel.text =  cart.unit
        self.orderImage.kf.setImage(with: URL(string: cart.image.orEmpty))
    }

   
    
    @IBAction func increaseButtonTapped(_ sender: Any) {
        count += 1
        updateAction?(count, id.orEmpty)
    }
    
    @IBAction func decreaseButtonTapped(_ sender: Any) {
        if count > 1 {
            count -= 1
            updateAction?(count, id.orEmpty)
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        deleteAction?(productID.orEmpty ,id.orEmpty)
    }
    
}
