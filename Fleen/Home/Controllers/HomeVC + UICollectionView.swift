//
//  HomeVC + UICollectionView.swift
//  Fleen
//
//  Created by Mina Eid on 04/02/2024.
//

import UIKit

extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            
        case adsCollectionView :
            return viewModel.numberOfBannersRows(in: section)
            
        case filterCollectioView :
            return viewModel.numberOfFilterRows(in: section)
            
        case productsCollectionView:
            return viewModel.numberOfProductssRows(in: section)
            
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            
        case adsCollectionView:
            let cell = adsCollectionView.dequeueReusableCell(withReuseIdentifier: AdsCollectionViewCell.identifier, for: indexPath) as! AdsCollectionViewCell
            cell.config(viewModel: self.addsCellDataSource[indexPath.row])
            return cell
            
        case filterCollectioView :
            let cell = filterCollectioView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as! FilterCollectionViewCell
            let isSelected = (selectIndexInFilter == indexPath.row) ? true : false
            cell.config(viewModel: self.filterCellDataSource[indexPath.row], isSelected)
            return cell
            
        case productsCollectionView :
            let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.identifier, for: indexPath) as! ProductsCollectionViewCell
            cell.config(viewModel: self.productsCellDataSource[indexPath.row])
            return cell
     
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
            
        case adsCollectionView:
            print("adsselect")
            
        case filterCollectioView:
            
            selectIndexInFilter = indexPath.row
            if let selectedCategoryID = self.filterCellDataSource[indexPath.row].id {
                self.viewModel.productsCellDataSource.value = []
                self.viewModel.getHomeData(viewController: self, category: String(selectedCategoryID))
                self.filterCollectioView.reloadData()
            }
            
        case productsCollectionView :
            let item = productsCellDataSource[indexPath.row].id
            self.openDetails(productsID: item.orEmpty)
        default:
            print("none")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case adsCollectionView :
            return CGSize(width: adsCollectionView.frame.width  , height: adsCollectionView.frame.height)
        case filterCollectioView :
            return CGSize(width: 80  , height: filterCollectioView.frame.height)
        case productsCollectionView :
                return CGSize(width: 160 , height: 190)
        default:
            print("non")
        }
        return CGSize()
    }
}



