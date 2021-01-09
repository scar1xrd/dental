//
//  CollectionViewAdapter.swift
//  Dental
//
//  Created by Igor Sorokin on 12.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol CollectionDataSourceDelegate: UICollectionViewDataSource, UICollectionViewDelegate {}

final class CollectionViewAdapter<Element, CellViewType, SupplementaryView>: NSObject, CollectionDataSourceDelegate
    where CellViewType: UIView & CellView, SupplementaryView: UICollectionReusableView {
    
    // MARK: Private properties
    private let disposeBag: DisposeBag = .init()
    
    // MARK: Public properties
    weak var collectionView: UICollectionView?
    
    var elements: BehaviorRelay<[Element]?> = .init(value: nil)
    var didSelectRow: ((Element) -> Void)?
    var onCellForItemAt: ((CellViewType, Element?) -> Void)?
    var configureSupplementaryViewHandler: ((SupplementaryView, Element?, String) -> Void)?
    
    init(collectionView: UICollectionView) {
        super.init()
        self.collectionView = collectionView
        
        setupHandler()
    }
    
    private func setupHandler() {
        elements
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (_) in
                self.collectionView?.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Data Source
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let view: SupplementaryView = collectionView.dequeueSupplementaryView(kind: kind, for: indexPath)
        configureSupplementaryViewHandler?(view, elements.value?[indexPath.row], kind)
        return view
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        elements.value?.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: GenericCollectionViewCell<CellViewType> = collectionView.dequeueReusableCell(for: indexPath)
        
        if cell.view == nil {
            let cellContentView = CellViewType.init()
            cell.setup(view: cellContentView)
        }
        
        onCellForItemAt?(cell.view, elements.value?[indexPath.row])
        
        return cell
    }
    
    // MARK: - Delegate
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let element = elements.value?[indexPath.row] else { return }
        didSelectRow?(element)
    }
}
