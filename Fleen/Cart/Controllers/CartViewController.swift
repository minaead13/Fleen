//
//  CartViewController.swift
//  Fleen
//
//  Created by Mina Eid on 30/01/2024.
//

import UIKit
import MOLH
import DropDown

class CartViewController: UIViewController , UITextFieldDelegate, LocationViewControllerDelegate  {

    @IBOutlet weak var LocationTextField: UITextField!
    @IBOutlet weak var paymentTextField: UITextField!
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var deliveryTimeLabel: UILabel!
    @IBOutlet weak var timeSegment: UISegmentedControl!
    @IBOutlet weak var timeCollectionView: UICollectionView!
    @IBOutlet weak var privacyLabel: UILabel!
    @IBOutlet weak var totalOrderLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var sentBtn: UIButton!
    var selectIndexInFilter: Int?
    private var locationDropdownView : UIView!
    let viewModel = CartViewModel()
    let dropDown = DropDown()
    var paymentArray : [payment] = [
            payment(title: "pay cash".localized, image: UIImage(named: "cash")!,id: 2),
            payment(title: "Payment via mada".localized, image:  UIImage(named: "mada")!,id: 3),
            payment(title: "Payment via wallet".localized, image:  UIImage(named: "wallet")! , id: 1)
    ]
    var spinnerView: UIView?
    var itemsCellDataSource = [CartCellViewModel]()
    var amDeliveryTime : [Time]?
    var pmDeliveryTime : [Time]?
    var locationArray : [AddressModel]?
    var selectedArray: [Time]? {
        return timeSegment.selectedSegmentIndex == 0 ? amDeliveryTime : pmDeliveryTime
    }
    var locationTableView : UITableView!
    var paymentTableView : UITableView!
    private var addLocationButton : UIButton!
    var totalPrice: Double = 0.0
    var previouslySelectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.tabBarController?.tabBar.isHidden = true
        
        bindingViewModel()
        getData()
        getAddress()
        setTimeSegment()
        setupDropdownViews()
        setupTapGesture()
        
        LocationTextField.isEnabled = false
        paymentTextField.isEnabled = false
        
        setTableView()
        setFonts()
        setData()
        setCollectioView()
        checkLanguage()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setCollectioView()
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.tabBarController?.tabBar.isHidden = true
        self.locationTableView.reloadData()
        getAddress()
        self.locationTableView.reloadData()
    }
    
    
    func checkLanguage(){
        //LanguageHelper.language.currentLanguage() ==
        if MOLHLanguage.currentAppleLanguage() == "ar" {

            //navigationController?.navigationBar.semanticContentAttribute = .forceLeftToRight
            LocationTextField.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
            LocationTextField.textAlignment = .right
            
            paymentTextField.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
            paymentTextField.textAlignment = .right
            
            deliveryTimeLabel.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
            
        } else {
            //navigationController?.navigationBar.semanticContentAttribute = .forceLeftToRight
            LocationTextField.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
            LocationTextField.textAlignment = .left
            
            paymentTextField.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
            paymentTextField.textAlignment = .left
            
            deliveryTimeLabel.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight

        }
    }
    
    func locationViewControllerDidSendLocation() {
        getAddress()
    }
    
    func setTimeSegment(){
        timeSegment.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        timeCollectionView.reloadData()
    }
    
    private func setupDropdownViews() {
        setBtnLocationAction()
        setBtnPaymentAction()
        createDropdownView()
        creatTableViewDropDownView()
    }
    
    private func setupTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func textFieldEditingChanged(){
        showDropdown()
    }
    
    func setBtnLocationAction(){
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.backgroundColor = .clear 
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
    
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: LocationTextField.topAnchor),
            button.leadingAnchor.constraint(equalTo: LocationTextField.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: LocationTextField.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: LocationTextField.bottomAnchor)
        ])
        
        button.addTarget(self, action: #selector(textFieldEditingChanged), for: .touchUpInside)
    }
    
    func setBtnPaymentAction(){
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: paymentTextField.topAnchor),
            button.leadingAnchor.constraint(equalTo: paymentTextField.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: paymentTextField.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: paymentTextField.bottomAnchor)
        ])
        button.addTarget(self, action: #selector(appear), for: .touchUpInside)
    }
    
    @objc func appear(){
        showTableViewDropdown()
    }
    
    func creatTableViewDropDownView(){
        paymentTableView = UITableView()
        paymentTableView.delegate = self
        paymentTableView.dataSource = self
        paymentTableView.isUserInteractionEnabled = true
        paymentTableView.isHidden = true
        paymentTableView.registerCell(cell: LocationTableViewCell.self)
        view.addSubview(paymentTableView)
        paymentTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            paymentTableView.topAnchor.constraint(equalTo: paymentTextField.bottomAnchor, constant: 4),
            paymentTableView.leadingAnchor.constraint(equalTo: paymentTextField.leadingAnchor),
            paymentTableView.trailingAnchor.constraint(equalTo: paymentTextField.trailingAnchor),
            paymentTableView.widthAnchor.constraint(equalTo: paymentTextField.widthAnchor),
            paymentTableView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func createDropdownView() {

        locationTableView = UITableView()
        locationTableView.delegate = self
        locationTableView.dataSource = self
        locationTableView.isUserInteractionEnabled = true
        locationTableView.registerCell(cell: LocationTableViewCell.self)
        
       
        addLocationButton = UIButton()
        addLocationButton.setTitle("New location".localized, for: .normal)
        addLocationButton.setTitleColor(.white, for: .normal)
        let tabBarColor = UIColor(red: CGFloat(35) / 255.0,green: CGFloat(170) / 255.0,blue: CGFloat(73) / 255.0, alpha: 1.0)
        addLocationButton.backgroundColor = tabBarColor
        addLocationButton.cornerRadius = 20
        addLocationButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
  
        locationDropdownView = UIView()
        locationDropdownView.isHidden = true
        locationDropdownView.backgroundColor = .secondarySystemGroupedBackground
        locationDropdownView.borderColor = .secondarySystemGroupedBackground
        locationDropdownView.borderWidth = 0.6
        locationDropdownView.cornerRadius = 16
        
        
        locationTableView.translatesAutoresizingMaskIntoConstraints = false
        addLocationButton.translatesAutoresizingMaskIntoConstraints = false
        
        locationDropdownView.addSubview(locationTableView)
        locationDropdownView.addSubview(addLocationButton)
        
        locationDropdownView.translatesAutoresizingMaskIntoConstraints = false
   
        view.addSubview(locationDropdownView)
        
        NSLayoutConstraint.activate([
            locationDropdownView.topAnchor.constraint(equalTo: LocationTextField.bottomAnchor, constant: 4),
            locationDropdownView.leadingAnchor.constraint(equalTo: LocationTextField.leadingAnchor),
            locationDropdownView.trailingAnchor.constraint(equalTo: LocationTextField.trailingAnchor),
            locationDropdownView.widthAnchor.constraint(equalTo: LocationTextField.widthAnchor),
            locationDropdownView.heightAnchor.constraint(equalToConstant: 160)
        ])

        NSLayoutConstraint.activate([
            locationTableView.topAnchor.constraint(equalTo: locationDropdownView.topAnchor , constant: 4),
            locationTableView.leadingAnchor.constraint(equalTo: locationDropdownView.leadingAnchor, constant: 4),
            locationTableView.trailingAnchor.constraint(equalTo: locationDropdownView.trailingAnchor, constant: -4),
            locationTableView.heightAnchor.constraint(equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            addLocationButton.topAnchor.constraint(equalTo: locationTableView.bottomAnchor, constant: 10),
            addLocationButton.leadingAnchor.constraint(equalTo: locationDropdownView.leadingAnchor, constant: 20),
            addLocationButton.trailingAnchor.constraint(equalTo: locationDropdownView.trailingAnchor, constant: -20),
            addLocationButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        let locationDropdownFrame = locationDropdownView.convert(locationDropdownView.bounds, to: view)
        let paymentTableFrame = paymentTableView.convert(paymentTableView.bounds, to: view)
        if !locationDropdownFrame.contains(sender.location(in: view)) {
            hideDropdown()
        }
        if !paymentTableFrame.contains(sender.location(in: view)) {
            hideTableViewDropdown()
        }
    }
    
    func showTableViewDropdown() {
        paymentTableView.allowsSelection = true
        UIView.animate(withDuration: 0.3) {
            self.paymentTableView.frame.size.height = 80
            self.paymentTableView.isHidden = false
        }
    }
    
    func hideTableViewDropdown() {
        UIView.animate(withDuration: 0.3) {
            self.paymentTableView.frame.size.height = 0
            self.paymentTableView.isHidden = true
        }
    }

    func showDropdown() {
        locationTableView.allowsSelection = true
        UIView.animate(withDuration: 0.3) {
            self.locationDropdownView.frame.size.height = 160
            self.locationDropdownView.isHidden = false
        }
    }

    func hideDropdown() {
        UIView.animate(withDuration: 0.3) {
            self.locationDropdownView.frame.size.height = 0
            self.locationDropdownView.isHidden = true
        }
    }

    @objc func buttonTapped() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddLocationViewController") as! AddLocationViewController
        self.hideDropdown()
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
  
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setTableView(){
        orderTableView.registerCell(cell: OrdersTableViewCell.self)
    }
    
    private func setCollectioView(){
        timeCollectionView.registerCell(cell: TimeCollectionViewCell.self)
    }
    
    private func setFonts(){
        deliveryTimeLabel.font = UIFont(name: "DMSans-Bold", size: 12)
        privacyLabel.font = UIFont(name: "DMSans18pt-Regular", size: 12)
        totalOrderLabel.font = UIFont(name: "DMSans-Bold", size: 16)
        sentBtn.titleLabel?.font = UIFont(name: "DMSans18pt-Regular", size: 16)
    }
    
    private func setData(){
        LocationTextField.text = "choose your location".localized
        paymentTextField.text = "choose your payment method".localized
        deliveryTimeLabel.text = "delivery time".localized
        totalOrderLabel.text = "total order".localized
        sentBtn.setTitle("sent the order".localized, for: .normal)
        let attributes: [NSAttributedString.Key: Any] = [
                    NSAttributedString.Key.font: UIFont(name: "DMSans18pt-Regular", size: 14)!]
        timeSegment.setTitleTextAttributes(attributes, for: .normal)
        timeSegment.setTitle("pm".localized, forSegmentAt: 0)
        timeSegment.setTitle("am".localized, forSegmentAt: 1)
        
        if  MOLHLanguage.currentAppleLanguage() == "ar"  {
            let sentence = "من خلال تنفيذ الأمر، فإنك توافق على الشروط والأحكام. جميع الأسعار تشمل 15% ضريبة القيمة المضافة"
            privacyLabel.text = sentence
            let attributedString = NSMutableAttributedString(string: sentence)
            let termsAndConditionsAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.gold]
            if let rangeOfTermsAndConditions = sentence.range(of: "الشروط والأحكام") {
                let nsRange = NSRange(rangeOfTermsAndConditions, in: sentence)
                attributedString.addAttributes(termsAndConditionsAttributes, range: nsRange)
            }
            privacyLabel.attributedText = attributedString
        } else {
            let sentence = "By executing the order, you agree to the terms and conditions. All prices include 15% value-added tax"
            privacyLabel.text = sentence
            let attributedString = NSMutableAttributedString(string: sentence)
            let termsAndConditionsAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.gold]
            if let rangeOfTermsAndConditions = sentence.range(of: "the terms and conditions") {
                let nsRange = NSRange(rangeOfTermsAndConditions, in: sentence)
                attributedString.addAttributes(termsAndConditionsAttributes, range: nsRange)
            }
            privacyLabel.attributedText = attributedString
        }
    }
    
    func bindingViewModel(){
        viewModel.isLoading.bind { [weak self] isLoading in
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
        viewModel.cartCellDataSource.bind { [weak self] items in
            guard let self = self , let items = items else { return }
            self.itemsCellDataSource = items
            self.orderTableView.reloadData()
        }
    }
    
    func getAddress(){
        viewModel.getAddresses(viewController: self){ [weak self] data in
            self?.locationArray = data?.data
            self?.locationTableView.reloadData()
            
        }
    }
    
    func getData(){
        viewModel.getCartData(viewController: self) { [weak self] data in
            guard let data = data?.data else {
                print("No data available.")
                return
            }
            self?.orderTableView.reloadData()
            DispatchQueue.main.async {
                self?.totalPriceLabel.text = data.total
            }
            
            guard let deliveryTimes = data.delivery_times else {
                print("No delivery times available.")
                return
            }
            
            for deliveryTime in deliveryTimes {
                guard let type = deliveryTime.type else {
                    print("Type is nil for delivery time.")
                    continue
                }
                
                switch type {
                case "am".localized:
                    print("AM delivery times: \(deliveryTime.times ?? [])")
                    self?.timeCollectionView.reloadData()
                    self?.amDeliveryTime = deliveryTime.times
                case "pm".localized:
                    print("PM delivery times: \(deliveryTime.times ?? [])")
                    self?.timeCollectionView.reloadData()
                    self?.pmDeliveryTime = deliveryTime.times
                default:
                    print("Unexpected delivery time type: \(type)")
                }
            }
        }
        
        DispatchQueue.main.async {
            self.timeSegment.selectedSegmentIndex = 0
            self.timeCollectionView.reloadData()
        }
    }
    
    func showLoadingIndicator(){
        spinnerView = displaySpinner(onView: self.view)
    }
    
    func hideLoadingIndicator() {
        if let sv = spinnerView{
            removeSpinner(spinner: sv)
        }
    }
    
    
    @IBAction func didTapSendBtn(_ sender: Any) {
       
        if viewModel.checkID(viewController: self) {
            viewModel.sendOrder(viewController: self, address: viewModel.addressID.orEmpty, delivery_time: viewModel.deliveryTime.orEmpty, payment_type: viewModel.paymentType.orEmpty) { [weak self] data in
                guard let self = self else { return }
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ThanksViewController") as! ThanksViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}



