//
//  NewsViewController.swift
//  Dental
//
//  Created by scar1xrd on 06/01/2020.
//  Copyright 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class NewsViewController: TableViewController, View {
    // MARK: Private properties
    private let disposeBag: DisposeBag = .init()
    private var viewModel: NewsViewModel!
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<NewsSectionModel> = {
        RxTableViewSectionedReloadDataSource<NewsSectionModel>(
            configureCell: self.configureCell(_:tableView:indexPath:news:)
        )
    }()
    
    deinit {
        print("DEINIT \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

// MARK: - VIEW MODEL INJECTABLE

extension NewsViewController: ViewModelInjectable {
    func set(viewModel: ViewModel) {
        self.viewModel = viewModel as? NewsViewModel
    }
}

// MARK: - CONFIGURATIONS

private extension NewsViewController {
    func configure() {
        configureNavigation()
        configureViews()
        setupBindings()
        configureViewModel()
        
        viewModel.loadAction.execute()
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func configureViews() {
        tableView.isHidden = true
        tableView.register(cellClass: NewsTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
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
    
    func configureCell(
        _ dataSource: TableViewSectionedDataSource<NewsSectionModel>,
        tableView: UITableView,
        indexPath: IndexPath,
        news: NewsContent
    ) -> UITableViewCell {
        let cell: NewsTableViewCell = tableView.dequeueReusableCell()
        cell.titleLabel.text = news.title
        cell.contentLabel.text = news.content
        
        if let url = URL(string: news.srcImage) {
            cell.articleImageView.setRoundOverlay(imageSize: NewsTableViewCell.imageSize(), url: url)
        }
        
        return cell
    }
    
    func setupBindings() {
        refreshControl.rx.bind(to: viewModel.reloadAction, input: ())
        
        tableView
            .addPagination(actionRelay: viewModel.loadItemIfNeeded)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] (indexPath) in
                self.viewModel.showNewsDetails(at: indexPath)
            })
            .disposed(by: disposeBag)
    }
    
    func configureViewModel() {
        viewModel.title.drive(rx.title).disposed(by: disposeBag)
        
        viewModel.news.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.loadAction
            .onElements(action: { [unowned self] (_) in
                self.hideErrorView()
                self.tableView.isHidden = false
            })
            .disposed(by: disposeBag)
        
        viewModel.loadAction
            .onApiErrors(action: { [unowned self] _ in
                self.showErrorView()
            })
            .disposed(by: disposeBag)
        
        viewModel.loadAction
            .onExecuting(
                executingAction: { [unowned self] in
                    self.hideErrorView()
                    self.showHUD()
                }, nonExecutingAction: { [unowned self] in
                    self.hideHUD()
                })
            .disposed(by: disposeBag)
    }
    
    // MARK: Actions
    
    @objc private func errorButtonTapped() {
        viewModel.loadAction.execute()
    }
    
}
