//
//  UICollectionView+extension.swift
//  Dental
//
//  Created by Igor Sorokin on 12.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(cellClass: T.Type) {
        self.register(
            cellClass.self,
            forCellWithReuseIdentifier: String(describing: cellClass.self)
        )
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(
            withReuseIdentifier: String(describing: T.self),
            for: indexPath
        ) as? T else {
            fatalError("Unable to Dequeue Reusable Collection View Cell")
        }
        return cell
    }
    
    func registerSupplementaryView<T: AnyObject>(view: T.Type, kind: String) {
        self.register(
            view.self,
            forSupplementaryViewOfKind: kind,
            withReuseIdentifier: String(describing: T.self)
        )
    }
    
    func dequeueSupplementaryView<T: AnyObject>(kind: String, for indexPath: IndexPath) -> T {
        guard let view = self.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: String(describing: T.self),
            for: indexPath
        ) as? T else {
            fatalError("Unable to Dequeue Reusable Supplementary view")
        }
        return view
    }
}
