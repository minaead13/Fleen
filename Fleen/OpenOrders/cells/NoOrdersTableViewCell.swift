//
//  OrdersTableViewCell.swift
//  Fleen
//
//  Created by Mina Eid on 20/02/2024.
//

import UIKit
import MOLH

class NoOrdersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var requestLabel: UILabel!
    @IBOutlet weak var quantitLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var caseDeliveryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    // MARK: - Properties
    static let identifier = String(describing: NoOrdersTableViewCell.self)
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        return formatter
    }()
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        checkLanguage()
    }
    
    // MARK: - Configuration
    func config(viewModel: TotalOrdersCellViewModel) {
        iconImage.kf.setImage(with: URL(string: viewModel.icon.orEmpty))
        requestLabel.text = "Request no.".localized + " " + viewModel.order_number.orEmpty
        setQuantityLabel(count: viewModel.items_count)
        caseDeliveryLabel.text = viewModel.status
        priceLabel.text = viewModel.total
        setDate(date: viewModel.created_at.orEmpty)
    }
    
    private func setQuantityLabel(count: Int?) {
        guard let count = count else { return }
        let categoryWord = count == 1 ? "Category".localized : "Categories".localized
        quantitLabel.text = "\(count) \(categoryWord)"
    }
    
    private func setDate(date: String) {
        guard let date = dateFormatter.date(from: date) else {
            dataLabel.text = date
            return
        }
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "dd-MM-yyyy"
        dataLabel.text = outputDateFormatter.string(from: date)
    }
    
    private func checkLanguage(){
        let isArabic = MOLHLanguage.currentAppleLanguage() == "ar"
        let alignment: NSTextAlignment = isArabic ? .right : .left
        
        requestLabel.textAlignment = alignment
        quantitLabel.textAlignment = alignment
        dataLabel.textAlignment = alignment
    }
    
    // MARK: - UI Setup
    private func setUI() {
        [requestLabel, caseDeliveryLabel, priceLabel].forEach { $0?.font = UIFont(name: "DMSans-Bold", size: 16) }
        [quantitLabel, dataLabel].forEach { $0?.font = UIFont(name: "DMSans18pt-Regular", size: 14) }
    }
    
}
