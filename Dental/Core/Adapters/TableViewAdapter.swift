//
//  TableViewAdapter.swift
//  Dental
//
//  Created by Igor Sorokin on 06.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol TableViewSection {
    associatedtype HeaderModel
    associatedtype Item
    associatedtype FooterModel
    
    var header: HeaderModel { get }
    var items: [Item] { get }
    var footer: FooterModel { get }
}

protocol TableDataSourceDelegate: UITableViewDataSource, UITableViewDelegate {}

final class TableViewAdapter<Section, CellViewType>: NSObject, TableDataSourceDelegate
    where Section: TableViewSection, CellViewType: UIView & CellView {
    
    // MARK: Private properties
    private let disposeBag: DisposeBag = .init()
    
    // MARK: Public properties
    weak var tableView: UITableView?
    
    var sections: BehaviorRelay<[Section]?> = .init(value: nil)
    var heightForRow: CGFloat = UITableView.automaticDimension
    var didSelectRow: ((Section.Item) -> Void)?
    var onCellForRowAt: ((CellViewType, Section.Item?) -> Void)?
    
    var onViewForHeaderInSection: ((Section.HeaderModel) -> UIView?)?
    var onViewForFooterInSection: ((Section.FooterModel) -> UIView?)?
    
    init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        
        setupHandler()
    }
    
    private func setupHandler() {
        sections
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (_) in
                self.tableView?.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.value?.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        sections.value?[section].items.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell: GenericTableViewCell<CellViewType> = tableView.dequeueReusableCell()
        let element = sections.value?[indexPath.section].items[indexPath.row]
        
        if cell.view == nil {
            let cellContentView = CellViewType()
            cell.setup(view: cellContentView)
        }
        
        onCellForRowAt?(cell.view, element)
        
        return cell
    }
    
    // MARK: - Delegate
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        heightForRow
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard let element = sections.value?[indexPath.section].items[indexPath.row] else { return }
        didSelectRow?(element)
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        guard let headerModel = sections.value?[section].header else { return nil }
        return onViewForHeaderInSection?(headerModel)
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        onViewForHeaderInSection == nil ? 0.0 : UITableView.automaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {
        guard let footerModel = sections.value?[section].footer else { return nil }
        return onViewForFooterInSection?(footerModel)
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {
        onViewForFooterInSection == nil ? 0.0 : UITableView.automaticDimension
    }
    
}
