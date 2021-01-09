//
//  FilledTableViewController.swift
//  Dental
//
//  Created by Igor Sorokin on 01.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class TableViewController: BaseViewController {
    
    // MARK: UI
    weak var tableView: UITableView!
    weak var refreshControl: UIRefreshControl!
    weak var errorView: ErrorView!
    
    deinit {
        print("DEINIT \(self)")
    }
    
    override func loadView() {
        super.loadView()
        let view = FilledTableView()
        self.view = view
        tableView = view.tableView
        refreshControl = view.refreshControl
        errorView = view.errorView
    }

    func showErrorView() {
        errorView.isHidden = false
    }
    
    func hideErrorView() {
        errorView.isHidden = true
    }
    
}
