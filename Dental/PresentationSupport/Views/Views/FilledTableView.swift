//
//  FilledTableView.swift
//  Dental
//
//  Created by Igor Sorokin on 06.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import SnapKit

class FilledTableView: UIView {
    private(set) weak var tableView: UITableView!
    private(set) weak var refreshControl: UIRefreshControl!
    private(set) weak var errorView: ErrorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.backgroundColor = .app
        
        let tableView: UITableView = {
            let view = UITableView()
            view.backgroundColor = .app
            return view
        }()
        
        let refreshControl: UIRefreshControl = {
            let view = UIRefreshControl()
            view.tintColor = .common
            return view
        }()
        
        let errorView: ErrorView = {
            let view = ErrorView()
            view.isHidden = true
            view.errorLabel.text = L10n.Error.description
            view.reloadButton.setTitle(L10n.Error.reload, for: .normal)
            return view
        }()
        
        self.tableView = tableView
        self.refreshControl = refreshControl
        self.errorView = errorView
        
        addSubview(self.tableView)
        addSubview(self.errorView)
        
        self.tableView.refreshControl = self.refreshControl
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        errorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
