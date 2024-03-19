//
//  CartVC+UICollectionView.swift
//  Fleen
//
//  Created by Mina Eid on 08/02/2024.
//

import UIKit
extension CartViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("dataCount\(selectedArray?.count)")
        return (selectedArray?.count).orEmpty
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCollectionViewCell.identifier, for: indexPath) as! TimeCollectionViewCell
        
        let isSelected = (selectIndexInFilter == indexPath.row) ? true : false
        if let time = selectedArray?[indexPath.item] {
            cell.configureTimeCell(filterTitle: time, isSelected)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectIndexInFilter = indexPath.row
        timeCollectionView.reloadData()
        viewModel.deliveryTime = selectedArray?[indexPath.row].id
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100  , height: timeCollectionView.frame.height )
    }
}
