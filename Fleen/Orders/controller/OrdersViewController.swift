//
//  OrdersViewController.swift
//  Fleen
//
//  Created by Mina Eid on 19/02/2024.
//

import UIKit

class OrdersViewController: UIViewController {

    @IBOutlet weak var openView: UIView!
    @IBOutlet weak var openBtn: UIButton!
    @IBOutlet weak var endingView: UIView!
    @IBOutlet weak var endingBtn: UIButton!
    @IBOutlet weak var openContainer: UIView!
    @IBOutlet weak var endingContainer: UIView!
    
    let homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUI()
    }
    
    private func setUI(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        setData()
        selectContainer(isOpenSelected: true)
        getCartCount()
    }
    
    private func setData(){
        navigationItem.title = "Orders".localized
        openBtn.setTitle("Open".localized, for: .normal)
        endingBtn.setTitle("Finished".localized, for: .normal)
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
    
    private func selectContainer(isOpenSelected: Bool) {
        openView.backgroundColor = isOpenSelected ? .gold : .placeHolder
        openBtn.setTitleColor(isOpenSelected ? .gold : .placeHolder, for: .normal)
        openBtn.setTitleColor(isOpenSelected ? .gold : .placeHolder, for: .selected)
        openBtn.tintColor = isOpenSelected ? .gold : .placeHolder
        endingView.backgroundColor = isOpenSelected ? .placeHolder : .gold
        endingBtn.setTitleColor(isOpenSelected ? .placeHolder : .gold, for: .normal)
        endingBtn.setTitleColor(isOpenSelected ? .placeHolder : .gold, for: .selected)
        endingBtn.tintColor = isOpenSelected ? .placeHolder : .gold
        
        openContainer.isHidden = !isOpenSelected
        endingContainer.isHidden = isOpenSelected
    }

    @IBAction func didTapOpenBtn(_ sender: Any) {
        selectContainer(isOpenSelected: true)
    }
    
    
    
    @IBAction func didTapEndingBtn(_ sender: Any) {
        selectContainer(isOpenSelected: false)
    }
    
}
