//
//  DentistsViewController.swift
//  Dental
//
//  Created by scar1xrd on 08/02/2020.
//  Copyright 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import RxSwift

class DentistsViewController: TableViewController, View {
    // MARK: Private properties
    private let disposeBag: DisposeBag = .init()
    private var viewModel: DentistsViewModel!
    
    private var tableViewAdapter: TableViewAdapter<AddressDentistsSection, DentistsContentView>!
    
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

extension DentistsViewController: ViewModelInjectable {
    func set(viewModel: ViewModel) {
        self.viewModel = viewModel as? DentistsViewModel
    }
}

// MARK: - CONFIGURABLE PROVIDER

extension DentistsViewController: ConfigurableProvider {
    var configurable: Configurable? { viewModel }
}

// MARK: - CONFIGURATIONS

private extension DentistsViewController {
    func configure() {
        navigationItem.largeTitleDisplayMode = .never
        configureAdapter()
        configureViews()
        setupBindings()
        configureHandlers()
        
        viewModel.loadDentists.execute()
    }
    
    func configureAdapter() {
        tableViewAdapter = TableViewAdapter(tableView: tableView)
        
        tableViewAdapter.onCellForRowAt = { view, dentist in
            guard let dentist = dentist else { return }
            
            view.dentistNameLabel.text = dentist.name
            
            if let url = URL(string: dentist.srcImage) {
                view.dentistImageView.setRoundOverlay(
                    cornerRadius: 27,
                    imageSize: view.dentistImageView.bounds.size,
                    url: url
                )
            }
            
            dentist.branch.forEach {
                view.setDentistBranch($0)
            }
        }
        
        tableViewAdapter.onViewForHeaderInSection = { address in
            let view = AddressHeaderView()
            
            guard let range = address?.range(of: "ул.") else { return view }
            let street = address?[range.lowerBound...]
            view.titleLabel.text = String(street ?? "")
            
            return view
        }
        
        tableViewAdapter.didSelectRow = { [unowned self] dentist in
            self.viewModel.showDentist(dentist)
        }
    }
    
    func configureViews() {
        tableView.dataSource = tableViewAdapter
        tableView.delegate = tableViewAdapter
        
        tableView.tableFooterView = UIView()
        tableView.refreshControl = nil
        tableView.registerHeaderFooterView(viewClass: AddressHeaderView.self)
        tableView.register(cellClass: GenericTableViewCell<DentistsContentView>.self)
        tableView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: view.safeAreaInsets.bottom,
            right: 0
        )
    }
    
    func setupBindings() {
        viewModel.title.drive(rx.title).disposed(by: disposeBag)
        
        viewModel.addressDentistsSection
            .bind(to: tableViewAdapter.sections)
            .disposed(by: disposeBag)
    }
    
    func configureHandlers() {
        viewModel.loadDentists
            .onApiErrors(action: { [unowned self] _ in self.showErrorView() })
            .disposed(by: disposeBag)
        
        viewModel.loadDentists
            .onExecuting(
                executingAction: { [unowned self] in
                    self.hideErrorView()
                    self.showHUD()
                }, nonExecutingAction: { [unowned self] in
                    self.hideHUD()
            })
            .disposed(by: disposeBag)
    }
}
