//
//  ItemDetailsViewController.swift
//  Fleen
//
//  Created by Mina Eid on 29/01/2024.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var addCount: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var itemScrollView: UIScrollView!
    
    var count = 1
    var countries : [Country] = []
    var selectedCountryDegress : [Degree] = []
    var productID : Int?
    var countryID : Int?
    var degreeID : Int?
    var viewModel : itemDetailsViewModel?
    var spinnerView: UIView?
    let homeViewModel = HomeViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        updateCountLabel()
        setNavigationBar()
    
    
        setUI()
        setFonts()
        
        bindingViewModel()
        getCartCount()
        setData()
        setPickerView()
    }
    
    private func setPickerView(){
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.selectRow(0, inComponent: 0, animated: false)
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
    }
    
    func setData(){
        viewModel?.getDetails(viewController: self, id: String(viewModel?.id ?? 0)){ [weak self] data in
            if let image = data?.data?.image {
                self?.productImage.kf.setImage(with: URL(string: image))
            }
            
            if let name = data?.data?.name.orEmpty {
                self?.titleLabel.text = name
            }
            
            if let description = data?.data?.description {
                self?.descriptionTextField.text = description.htmlToString
            }
            
            if let price = data?.data?.price {
                self?.subTitleLabel.text = price
            }
            
            if let countries = data?.data?.countries {
                self?.countries = countries
                self?.pickerView.reloadAllComponents()
            }
            
            if let degrees = data?.data?.countries?.first?.degrees {
                self?.selectedCountryDegress = degrees
                self?.pickerView.reloadAllComponents()
            }
            
            if let productID = data?.data?.id {
                self?.productID = productID
            }
            
            if let unit = data?.data?.unit,
               let count = data?.data?.unit_contains_count,
               let subUnit = data?.data?.sub_unit {
                
                let unitAttributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.gold
                ]
                let unitString = NSAttributedString(string: unit, attributes: unitAttributes)

                let subUnitAttributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.gold
                ]
                let subUnitString = NSAttributedString(string: subUnit, attributes: subUnitAttributes)

                let detailsText = NSMutableAttributedString()
                detailsText.append(NSAttributedString(string: "Each".localized))
                detailsText.append(NSAttributedString(string: " "))
                detailsText.append(unitString)
                detailsText.append(NSAttributedString(string: " "))
                detailsText.append(NSAttributedString(string: "contains".localized))
                detailsText.append(NSAttributedString(string: " "))
                detailsText.append(NSAttributedString(string: "on".localized))
                detailsText.append(NSAttributedString(string: " "))
                detailsText.append(NSAttributedString(string: count))
                detailsText.append(NSAttributedString(string: " "))
                detailsText.append(subUnitString)
                self?.detailsLabel.attributedText = detailsText
        
            }
        }
    }
        
    func showLoadingIndicator() {
        spinnerView = displaySpinner(onView: self.view)
    }
    
    func hideLoadingIndicator() {
        if let sv = spinnerView{
            removeSpinner(spinner: sv)
        }
    }
   
    private func setUI(){
        addCount.setTitle("", for: .normal)
        minusBtn.setTitle("", for: .normal)
        addCount.setImage(UIImage(named: "plus"), for: .normal)
        minusBtn.setImage(UIImage(named: "minus"), for: .normal)
    }
    
    private func setFonts(){
        titleLabel.font = UIFont(name: "DMSans-Bold", size: 24)
        subTitleLabel.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        countLabel.font = UIFont(name: "DMSans18pt-Regular", size: 18)
        detailsLabel.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        descriptionTextField.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        addBtn.titleLabel?.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        addBtn.setTitle("Add to cart".localized, for: .normal)
    }
    
    private func updateCountLabel(){
        countLabel.text = "\(count)"
    }
    
    private func setNavigationBar(){
        self.tabBarController?.tabBar.isHidden = true
        
        let tabBarColor = UIColor(red: CGFloat(243) / 255.0,green: CGFloat(245) / 255.0,blue: CGFloat(247) / 255.0, alpha: 1.0)
        self.navigationController?.navigationBar.backgroundColor = tabBarColor
        
        let coloredView = UIView()
        coloredView.backgroundColor = tabBarColor
        
        view.addSubview(coloredView)
        
        coloredView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coloredView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coloredView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coloredView.topAnchor.constraint(equalTo: view.topAnchor),
            coloredView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor) 
        ])
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func setShoppingCart(){
        let customButton = UIButton(type: .system)
        customButton.setImage(UIImage(named: "shopping-cart"), for: .normal)
        customButton.setTitle("", for: .normal)
        customButton.addTarget(self, action: #selector(customButtonPressed), for: .touchUpInside)
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        customView.addSubview(customButton)
        customButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customButton.centerXAnchor.constraint(equalTo: customView.centerXAnchor , constant: 10),
            customButton.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
        ])
        let rightBarButtonItem = UIBarButtonItem(customView: customView)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func getCartCount() {
        homeViewModel.getCartCount(viewController: self) { [weak self] data in
            guard let count = data?.data?.count else {
                self?.setupCartBadge(count: nil) // Hide badge if count is nil
                return
            }
            
            self?.setupCartBadge(count: count)
        }
    }
    
    @objc func customButtonPressed(){
        
    }
    
    @IBAction func didTapIncreaseBtn(_ sender: UIButton) {
        count += 1
        updateCountLabel()
    }
    
    
    @IBAction func didTapDecreaseBtn(_ sender: Any) {
        if count > 1 {
            count -= 1
            updateCountLabel()
        }
    }
    
    @IBAction func didTapAddBtn(_ sender: Any) {
        checkID()
    }
    
    private func checkID(){
        let cartCountryID = countryID ?? 1
        let cartDegreeID = degreeID ?? 1
        
        viewModel?.sendToCart(viewController: self, productID: productID.orEmpty, qty: count, countryID: cartCountryID, prodcutDegree: cartDegreeID, successCallback: {
            self.getCartCount()
            AppSnackBar.make(in: self.view, message: "The product added to shopping cart".localized, duration: .lengthLong).show()
        })
    }
}

