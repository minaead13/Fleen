//
//  RegisterViewController.swift
//  Fleen
//
//  Created by Mina Eid on 21/01/2024.
//

import UIKit
import DropDown
class RegisterViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var regionTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopNameTextField: UITextField!
    @IBOutlet weak var commercialLabel: UILabel!
    @IBOutlet weak var commercialTextField: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    
    
    let dropdownTableView = UITableView()
    let dropDown = DropDown()
    var dropDownArray : [String]?
    var spinnerView: UIView?
    var viewModel = RegisterViewModel()
    var isDropdownVisible = false
    var id : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingViewModel()
        
        viewModel.getAreas(viewController: self){ [weak self] data in
            self?.viewModel.items = data?.data
            self?.viewModel.filteredItems = self?.viewModel.items ?? []
            
            
            DispatchQueue.main.async {
                self?.dropdownTableView.reloadData()
            }
        }
        
        setNavigation()
        setFonts()
        setupTextField()
        setupDropdownTableView()
        
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
    }
    
    func bindingRegisterViewModel(){
        viewModel.isLoadingRegister.bind { [weak self] isLoading in
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
    
    func showLoadingIndicator() {
        spinnerView = displaySpinner(onView: self.view)
    }
    
    func hideLoadingIndicator() {
        if let sv = spinnerView{
            removeSpinner(spinner: sv)
        }
    }
    
    private func setNavigation(){
        navigationController?.navigationBar.tintColor = .black
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
    }
    
    private func setFonts(){
        titleLabel.font = UIFont(name: "DMSans-Bold", size: 28)
        subTitleLabel.font = UIFont(name: "DMSans18pt-Regular", size: 21)
        NameLabel.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        nameTextField.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        emailLabel.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        emailTextField.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        regionLabel.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        regionTextField.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        shopNameLabel.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        shopNameTextField.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        commercialLabel.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        commercialTextField.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        confirmBtn.titleLabel?.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        
        titleLabel.text = "New account".localized
        subTitleLabel.text = "Fill in the following data".localized
        NameLabel.text = "Name".localized
        nameTextField.placeholder = "Name".localized
        emailLabel.text = "Email (Optional)".localized
        regionTextField.placeholder = "select the area".localized
        regionLabel.text = "Region".localized
        shopNameLabel.text = "Shop name".localized
        shopNameTextField.placeholder = "Shop name".localized
        commercialLabel.text = "Commercial Registration No".localized
        confirmBtn.setTitle("Confirm".localized, for: .normal)
    }
    
    
    func setupTextField(){
        
        regionTextField.delegate = self
        emailTextField.delegate = self
        nameTextField.delegate = self
        shopNameTextField.delegate = self
        commercialTextField.delegate = self
        
        regionTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        
    }
    
    
    
    func setupDropdownTableView(){
        
        dropdownTableView.layer.borderColor = UIColor.gray.cgColor
        dropdownTableView.layer.borderWidth = 0.2
        dropdownTableView.layer.cornerRadius = 8.0
        dropdownTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(dropdownTableView)
        
        NSLayoutConstraint.activate([
            dropdownTableView.leadingAnchor.constraint(equalTo: regionTextField.leadingAnchor),
            dropdownTableView.trailingAnchor.constraint(equalTo: regionTextField.trailingAnchor),
            dropdownTableView.topAnchor.constraint(equalTo: regionTextField.bottomAnchor, constant: 5),
            dropdownTableView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        dropdownTableView.isHidden = true
        dropdownTableView.delegate = self
        dropdownTableView.dataSource = self
        dropdownTableView.isHidden = true
        
    }
    
    
    
    @objc func textFieldEditingChanged() {
        guard let searchText = regionTextField.text else {
            return
        }
        
        viewModel.filterItems(with: searchText)
        dropdownTableView.reloadData()
        showDropdown()
        
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == regionTextField {
            showDropdown()
        } else {
            hideDropdown()
        }
        
        return true
    }
    
    func showDropdown() {
        isDropdownVisible = true
        dropdownTableView.isHidden = false
    }
    
    func hideDropdown() {
        isDropdownVisible = false
        dropdownTableView.isHidden = true
    }
    
    @IBAction func didTapConfirmBtn(_ sender: Any) {
        validateAndShowAlert()
    }
    
    func validateAndShowAlert() {
        let name = nameTextField.text.orEmpty
        let email = emailTextField.text.orEmpty
        let region = regionTextField.text.orEmpty
        let shopName = shopNameTextField.text.orEmpty
        let comNumber = commercialTextField.text.orEmpty
        
        if !viewModel.validateFields(name: name, email: email, region: region, shopName: shopName, comNumber: comNumber) {
            showAlertError(title: "Invalid data!", message: viewModel.errorMessage)
        } else {
            bindingRegisterViewModel()
            
            
            viewModel.sendRegistrationRequest(viewController: self, name: name, email: email, area: "\(id.orEmpty)", shop_name: shopName, commercial_registration_number: comNumber){
                self.navigateToNextViewController()
            }
        }
    }
    

    private func navigateToNextViewController() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
    

extension RegisterViewController : UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier") ?? UITableViewCell(style: .default, reuseIdentifier: "CellIdentifier")
        
        cell.textLabel?.text = viewModel.filteredItems[indexPath.row].name
        cell.textLabel?.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = viewModel.items?[indexPath.row]
        regionTextField.text = selectedItem?.name
        id = selectedItem?.id
        hideDropdown()
    }
}
