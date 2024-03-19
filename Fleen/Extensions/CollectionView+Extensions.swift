//
//  CollectionView+Extensions.swift
//  Fleen
//
//  Created by Mina Eid on 29/01/2024.
//

import UIKit

extension UICollectionView {
    func registerCell<Cell: UICollectionViewCell>(cell: Cell.Type) {
        let nibName = String(describing: cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
    
    func dequeue<Cell:UICollectionViewCell>(indexPath: IndexPath) -> Cell {
        //MARK: - Generic dequeueReusableCells
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell else { fatalError("Error in cell")}
    
        return cell
    }
}
