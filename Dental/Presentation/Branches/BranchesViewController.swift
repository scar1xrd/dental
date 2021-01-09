//
//  BranchesViewController.swift
//  Dental
//
//  Created by scar1xrd on 01/02/2020.
//  Copyright 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import RxSwift

class BranchesViewController: TableViewController, View {
    // MARK: Private properties
    private let disposeBag: DisposeBag = .init()
    private var viewModel: BranchesViewModel!
    
    private var tableViewAdapter: TableViewAdapter<BranchSection, BranchContentView>!
    
    deinit {
        print("DEINIT \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - VIEW MODEL INJECTABLE

extension BranchesViewController: ViewModelInjectable {
    func set(viewModel: ViewModel) {
        self.viewModel = viewModel as? BranchesViewModel
    }
}

// MARK: - CONFIGURATIONS

private extension BranchesViewController {
    func configure() {
        configureNavigation()
        configureAdapter()
        configureViews()
        setupBindings()
        configureHandlers()
        
        viewModel.loadBranches.execute()
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func configureAdapter() {
        tableViewAdapter = TableViewAdapter(tableView: tableView)
        
        tableViewAdapter.onCellForRowAt = { view, model in
            guard let model = model else { return }
            
            view.titleLabel.text = model.branchName
            view.descriptionLabel.text = model.description
            
            if let url = URL(string: model.srcImage) {
                view.imageView.setRoundOverlay(
                    cornerRadius: 40,
                    imageSize: BranchContentView.imageViewSize(),
                    url: url
                )
            }
        }
        
        tableViewAdapter.didSelectRow = { [unowned self] model in
            self.viewModel.showDentistsForBranch(model.branchName)
        }
    }
    
    func configureViews() {
        tableView.delegate = tableViewAdapter
        tableView.dataSource = tableViewAdapter
        
        tableView.refreshControl = nil
        tableView.tableFooterView = UIView()
        tableView.register(cellClass: GenericTableViewCell<BranchContentView>.self)
        tableView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: view.safeAreaInsets.bottom,
            right: 0
        )
        
        errorView.reloadButton.addTarget(
            self,
            action: #selector(self.errorButtonTapped),
            for: .touchUpInside
        )
    }
    
    func setupBindings() {
//      viewModel.title.drive(rx.title).disposed(by: disposeBag)
        navigationItem.title = L10n.Branches.title
        
        viewModel.branchesSection
            .bind(to: tableViewAdapter.sections)
            .disposed(by: disposeBag)
    }
    
    func configureHandlers() {
        viewModel.loadBranches
            .onElements(action: { [unowned self] (_) in
                self.hideErrorView()
            })
            .disposed(by: disposeBag)
        
        viewModel.loadBranches
            .onApiErrors(action: { [unowned self] _ in
                self.showErrorView()
            })
            .disposed(by: disposeBag)
        
        viewModel.loadBranches
            .onExecuting(
                executingAction: { [unowned self] in
                    self.hideErrorView()
                    self.showHUD()
                }, nonExecutingAction: { [unowned self] in
                    self.hideHUD()
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func errorButtonTapped() {
        viewModel.loadBranches.execute()
    }
}
