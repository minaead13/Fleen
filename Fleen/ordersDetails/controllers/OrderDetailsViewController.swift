//
//  OrderDetailsViewController.swift
//  Fleen
//
//  Created by Mina Eid on 25/02/2024.
//

import UIKit
import MOLH
class OrderDetailsViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var contactBtn: UIButton!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var paymentTextField: UITextField!
    @IBOutlet weak var requestLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var deliveryCaseLabel: UILabel!
    @IBOutlet weak var totalOrderLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reorderBtn: UIButton!
    
    var itemsCellDataSource = [CartCellViewModel]()
    var spinnerView: UIView?
    var viewModel : OrderDetailsViewModel?
    let homeViewModel = HomeViewModel()
    var supportNumber : String?
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        checkLanguage()
        setFonts()
        self.tabBarController?.tabBar.isHidden = true
        bindingViewModel()
        getData()
        backBtn.setTitle("", for: .normal)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCartCount() 
    }
    
    private func setNavigationBar(){
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setFonts(){
        locationTextField.font = UIFont(name: "DMSans18pt-Regular", size: 12)
        paymentTextField.font = UIFont(name: "DMSans-Bold", size: 12)
        requestLabel.font = UIFont(name: "DMSans-Bold", size: 16)
        itemCountLabel.font = UIFont(name: "DMSans18pt-Regular", size: 18)
        datelabel.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        deliveryCaseLabel.font =  UIFont(name: "DMSans-Bold", size: 16)
        
        totalOrderLabel.text = "total order".localized
        
        let reorderAttributedTitle = self.attributedTitle(for: "Reorder".localized, font: UIFont(name: "DMSans18pt-Regular", size: 16)!)
        reorderBtn.setAttributedTitle(reorderAttributedTitle, for: .normal)
        
        let contactAttributedTitle = self.attributedTitle(for: "Contact support".localized, font: UIFont(name: "DMSans18pt-Regular", size: 16)!)
        contactBtn.setAttributedTitle(contactAttributedTitle, for: .normal)
    }
    
    func attributedTitle(for text: String, font: UIFont) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        return NSAttributedString(string: text.localized, attributes: attributes)
    }
    
   

    func checkLanguage(){
        let isArabic = MOLHLanguage.currentAppleLanguage() == "ar"
        let alignment: NSTextAlignment = isArabic ? .right : .left
        
        itemCountLabel.textAlignment = alignment
        requestLabel.textAlignment = alignment
        datelabel.textAlignment = alignment
        totalOrderLabel.textAlignment = alignment
        priceLabel.textAlignment = alignment
        
    }
    
    func bindingViewModel(){
        viewModel?.isLoading.bind { [weak self] isLoading in
            guard let self = self,
                  let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self.showLoadingIndicator()
                } else {
                    self.hideLoadingIndicator()
                }
            }
        }
        
        viewModel?.totalOrdersCellDataSource.bind{ [weak self] items in
            guard let self = self , let items = items else { return }
            itemsCellDataSource = items
            self.tableView.reloadData()
        }
    }
    
    private func setTableView(){
        tableView.registerCell(cell: OrdersTableViewCell.self)
    }
    
    func getData(){
        viewModel?.getOrderDetailsData(viewController: self, id: viewModel?.id ?? 0){ [weak self] totalOrders in
            
            self?.id = totalOrders?.data?.id
            self?.locationTextField.text = totalOrders?.data?.address_name
          
            
            self?.supportNumber = totalOrders?.data?.support_phone
            
            if totalOrders?.data?.payment_type == "1" {
                self?.paymentTextField.text = "Payment via wallet".localized
            } else if totalOrders?.data?.payment_type == "2" {
                self?.paymentTextField.text = "pay cash".localized
                self?.paymentTextField.setLeftImage(UIImage(named: "cash"))
            } else if totalOrders?.data?.payment_type == "3" {
                self?.paymentTextField.text = "Payment via mada".localized
            }
            
            if let order = totalOrders?.data {
                
                self?.requestLabel.text = "Request no.".localized + " " + order.order_number.orEmpty
                self?.setQuantityLabel(count: order.items_count)
                if let formattedDate = self?.formatDate(dateString: order.created_at.orEmpty) {
                    self?.datelabel.text = formattedDate
                } else {
                    self?.datelabel.text = order.created_at
                }
                self?.deliveryCaseLabel.text = order.status
                
                self?.priceLabel.text = order.total
            }
        }
    }
    
    func formatDate(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "d-M-yyyy | h:mm a"
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    private func setQuantityLabel(count: Int?) {
        guard let count = count else { return }
        let categoryWord = count == 1 ? "Category".localized : "Categories".localized
        itemCountLabel.text = "\(count) \(categoryWord)"
    }

    func showLoadingIndicator() {
        spinnerView = displaySpinner(onView: self.view)
    }
        
    func hideLoadingIndicator() {
        if let sv = spinnerView{
            removeSpinner(spinner: sv)
        }
    }
    
    func getCartCount() {
        homeViewModel.getCartCount(viewController: self) { [weak self] data in
            guard let count = data?.data?.count else {
                self?.setupCartBadge(count: nil)
                return
            }
            
            self?.setupCartBadge(count: count)
        }
    }
    
    
    @IBAction func didTapReOrder(_ sender: Any) {
        viewModel?.reorder(viewController: self, id: id.orEmpty ){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OrderConfirmationViewController") as! OrderConfirmationViewController
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func didTapContactBtn(_ sender: Any) {
        if let phoneURL = URL(string: "tel://\(supportNumber.orEmpty)"), UIApplication.shared.canOpenURL(phoneURL) {
                    UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        } else {
            print("Cannot make a phone call")
        }
    }
    

}



