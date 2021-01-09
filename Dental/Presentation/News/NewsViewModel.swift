//
//  NewsViewModel.swift
//  Dental
//
//  Created by scar1xrd on 06/01/2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

protocol NewsViewModel: ViewModel {
    var title: Driver<String> { get }
    var news: BehaviorRelay<[NewsSectionModel]> { get }
    
    var loadAction: Action<Void, News>! { get }
    var reloadAction: Action<Void, News>! { get }
    var loadItemIfNeeded: PublishRelay<Void> { get }
    
    func showNewsDetails(at indexPath: IndexPath)
}

class NewsViewModelImp: NewsViewModel {
    private let disposeBag: DisposeBag = .init()
    private let router: Router
    private let newsService: NewsService
    private let paginator: AnyPaginator<News>
    
    // MARK: Data
    var title: Driver<String> = .just(L10n.News.title)
    var news: BehaviorRelay<[NewsSectionModel]> = .init(value: [])
    
    // MARK: Actions
    var loadAction: Action<Void, News>!
    var loadMoreAction: Action<Int, News>!
    var reloadAction: Action<Void, News>!
    var loadItemIfNeeded: PublishRelay<Void> = .init()
    
    init(
        router: Router,
        newsService: NewsService,
        paginator: AnyPaginator<News>
    ) {
        self.router = router
        self.newsService = newsService
        self.paginator = paginator
        
        setupActions()
        setupPaginator()
    }
    
    deinit {
        print("DEINIT \(self)")
    }
    
    func showNewsDetails(at indexPath: IndexPath) {
        let news = self.news.value[indexPath.section].items[indexPath.row]
        
        router.show(SingleModuleItem.newsDetails) { (configurable) in
            guard let newsDetailsViewModel = configurable as? NewsDetailsViewModel else { return }
            newsDetailsViewModel.newsContent.accept(news)
        }
    }
    
    private func setupActions() {
        loadAction = Action { [unowned self] in
            self.newsService.getNews(page: 1)
        }
        
        self.loadMoreAction = Action { [unowned self] in
            self.newsService.getNews(page: $0)
        }
        
        self.reloadAction = Action { [unowned self] in
            self.newsService.getNews(page: 1)
        }
    }
    
    private func setupPaginator() {
        paginator.loadAction = loadAction
        paginator.loadMoreAction = loadMoreAction
        paginator.refreshAction = reloadAction
        
        loadItemIfNeeded
            .bind(to: paginator.loadItemsIfNeeded)
            .disposed(by: disposeBag)
        
        paginator.elements
            .subscribe(onNext: { [unowned self] (tuple) in
                let (news, _) = tuple
                self.news.accept([NewsSectionModel(model: 0, items: news)])
            })
            .disposed(by: disposeBag)
    }
    
}
