//
//  HomeVC+UISearch.swift
//  Fleen
//
//  Created by Mina Eid on 05/02/2024.
//

import UIKit

extension HomeViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchText = text
            selectIndexInFilter = nil
            self.viewModel.productsCellDataSource.value = []
            viewModel.getHomeData(viewController: self, keyword: searchText.orEmpty)
            productsCollectionView.reloadData()
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        selectIndexInFilter = nil
        filterCollectioView.reloadData()
        
        if searchText.isEmpty {
            self.viewModel.productsCellDataSource.value = []
            viewModel.getHomeData(viewController: self)
            productsCollectionView.reloadData()
        }
        
        //else {
//            selectIndexInFilter = nil
//            self.viewModel.productsCellDataSource.value = []
//            viewModel.getHomeData(viewController: self, keyword: searchText)
//        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchText = nil
        self.viewModel.productsCellDataSource.value = []
        viewModel.getHomeData(viewController: self)
        productsCollectionView.reloadData()
        searchBar.resignFirstResponder()

    }
    
}
