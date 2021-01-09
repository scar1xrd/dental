//
//  NewsDetailsViewController.swift
//  Dental
//
//  Created by scar1xrd on 11/01/2020.
//  Copyright 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import RxSwift

class NewsDetailsViewController: BaseViewController, View {
    // MARK: Private properties
    private let disposeBag: DisposeBag = .init()
    private var viewModel: NewsDetailsViewModel!
    private var collectionViewAdapter: CollectionViewAdapter<NewsContent, NewsDetailsContentView, BlurHeaderView>!
    
    // MARK: UI
    private weak var collectionView: UICollectionView!
    
    deinit {
        print("DEINIT \(self)")
    }
    
    override func loadView() {
        super.loadView()
        let view = NewsDetailsView()
        self.view = view
        collectionView = view.collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

// MARK: - VIEW MODEL INJECTABLE

extension NewsDetailsViewController: ViewModelInjectable {
    func set(viewModel: ViewModel) {
        self.viewModel = viewModel as? NewsDetailsViewModel
    }
}

// MARK: - CONFIGURABLE PROVIDER

extension NewsDetailsViewController: ConfigurableProvider {
    var configurable: Configurable? { viewModel }
}

// MARK: - CONFIGURATIONS

private extension NewsDetailsViewController {
    func configure() {
        navigationItem.largeTitleDisplayMode = .never
        configureViews()
        setupBindings()
    }
    
    func configureViews() {
        collectionViewAdapter = CollectionViewAdapter(collectionView: collectionView)
        collectionViewAdapter.configureSupplementaryViewHandler = configureSupplementaryView(_:newsContent:kind:)
        
        collectionViewAdapter.onCellForItemAt = { view, newsContent in
            view.titleLabel.text = newsContent?.title
            view.contentTextView.attributedText = NSAttributedString(
                string: newsContent?.content ?? "",
                attributes: .mediumDescription)
        }
        
        collectionView.dataSource = collectionViewAdapter
        collectionView.delegate = collectionViewAdapter
        
        collectionView.register(cellClass: GenericCollectionViewCell<NewsDetailsContentView>.self)
        collectionView.registerSupplementaryView(
            view: BlurHeaderView.self,
            kind: UICollectionView.elementKindSectionHeader
        )
    }
    
    func configureSupplementaryView(
        _ view: BlurHeaderView,
        newsContent: NewsContent?,
        kind: String
    ) {
        guard
            kind == UICollectionView.elementKindSectionHeader,
            let newsContent = newsContent
            else {
                return
            }
        
        if let url = URL(string: newsContent.srcImage) {
            view.imageView.setRoundOverlay(imageSize: BlurHeaderView.size(), url: url)
        }
        
        self.collectionView.rx.contentOffset
            .subscribe(onNext: { [unowned self] (contentOffset) in
                let yRealContentOffset = contentOffset.y + self.collectionView.adjustedContentInset.top
                
                guard yRealContentOffset < 0 else {
                    view.propertyAnimator.fractionComplete = 0
                    return
                }
                view.propertyAnimator.fractionComplete = abs(yRealContentOffset) / 100.0
            })
            .disposed(by: self.disposeBag)
    }
    
    func setupBindings() {
        viewModel.title.drive(rx.title).disposed(by: disposeBag)
        
        viewModel.newsContent
            .subscribe(onNext: { [unowned self] (newsContent) in
                guard let newsContent = newsContent else { return }
                self.collectionViewAdapter.elements.accept([newsContent])
            })
            .disposed(by: disposeBag)

    }
}
