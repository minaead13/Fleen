//
//  HomeViewController.swift
//  Fleen
//
//  Created by Mina Eid on 29/01/2024.
//

import UIKit
import UIScrollView_InfiniteScroll

class HomeViewController: UIViewController {
    
    @IBOutlet weak var adsCollectionView: UICollectionView!
    @IBOutlet weak var filterCollectioView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var spinnerView: UIView?
    var searchText: String?
    var filterCellCount: Int = 0
    var selectIndexInFilter: Int?
    var selectedIndexPath: IndexPath?
    let viewModel = HomeViewModel()
    var page = 1
    var barButtonItem: UIBarButtonItem?
    
    var addsCellDataSource = [addsCellViewModel]()
    var filterCellDataSource = [filterCellViewModel]()
    var productsCellDataSource = [productsCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectIndexInFilter = 0
        filterCollectioView.reloadData()
        self.navigationController?.navigationBar.isHidden = false

        getCartCount()
        setCollectionView()
        setNavigationBar()
        setupSearchBar() 
        bindingViewModel()
        viewModel.getHomeData(viewController: self, page: page)
        initLoadMoreToRefresh()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCartCount()
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func getCartCount() {
        viewModel.getCartCount(viewController: self) { [weak self] data in
            guard let count = data?.data?.count else {
                self?.setupCartBadge(count: nil)
                return
            }
            
            self?.setupCartBadge(count: count)
        }
    }
        
    func initLoadMoreToRefresh(){
        print("paggination")
        self.productsCollectionView?.infiniteScrollIndicatorStyle = .large
        
        self.productsCollectionView?.setShouldShowInfiniteScrollHandler { _ -> Bool in
            return self.page != self.viewModel.dataSource?.products.meta?.last_page
        }
        self.productsCollectionView?.addInfiniteScroll { (tableView) -> Void in
            
            if self.page == self.viewModel.dataSource?.products.meta?.last_page {
                self.productsCollectionView.finishInfiniteScroll()
            }else {
                self.page += 1
                self.viewModel.getHomeData(viewController: self ,page: self.page)
            }
        }
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
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
        
        viewModel.adsCellDataSource.bind { [weak self] ads in
            
            guard let self = self , let ads = ads else { return }
            self.addsCellDataSource = ads
            self.adsCollectionView.reloadData()
            
        }
        
        viewModel.filterCellDataSource.bind { [weak self] filters in
            
            guard let self = self , let filters = filters else { return}
            self.filterCellDataSource = filters
            self.filterCollectioView.reloadData()
        
        }
        
        viewModel.productsCellDataSource.bind { [weak self] products in
            
            guard let self = self , let products = products else { return }
            self.productsCellDataSource = products
            self.productsCollectionView.reloadData()
            
        }
    }
    
    
    func bindingfilterViewModel(){
        
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
        
        viewModel.productsCellDataSource.bind { [weak self] products in
            guard let self = self , let products = products else { return }
            self.productsCellDataSource = products
            self.productsCollectionView.reloadData()
            
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
    
    private func setNavigationBar(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.title = "Home".localized
        
        searchBar.placeholder = "Search now".localized
        searchBar.searchTextField.font = UIFont(name: "DMSans18pt-Regular", size: 14)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "notification"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        
        if let customFont = UIFont(name: "MSans-Bold", size: 20) {
            let attributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.font: customFont,
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
            
            self.navigationController?.navigationBar.titleTextAttributes = attributes
        }
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
   
    
    @objc func leftBarButtonTapped() {
      
    }
    
    func setCollectionView(){
        adsCollectionView.registerCell(cell: AdsCollectionViewCell.self)
        filterCollectioView.registerCell(cell: FilterCollectionViewCell.self)
        productsCollectionView.registerCell(cell: ProductsCollectionViewCell.self)
    }

    func openDetails(productsID : Int){
        guard let productsDetails = viewModel.retriveMovie(with: productsID ) else { return }
        
        let itemDetailsViewModel = itemDetailsViewModel(productsDetails: productsDetails)
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
          
          if let itemController = storyboard.instantiateViewController(withIdentifier: "ItemDetailsViewController") as? ItemDetailsViewController {
              itemController.viewModel = itemDetailsViewModel
              DispatchQueue.main.async {
                  self.navigationController?.pushViewController(itemController, animated: true)
              }
          }
    }
}




