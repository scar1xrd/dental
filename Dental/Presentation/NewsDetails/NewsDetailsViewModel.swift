//
//  NewsDetailsViewModel.swift
//  Dental
//
//  Created by scar1xrd on 11/01/2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

protocol NewsDetailsViewModel: ViewModel, Configurable {
    var title: Driver<String> { get }
    var newsContent: BehaviorRelay<NewsContent?> { get }
}

class NewsDetailsViewModelImp: NewsDetailsViewModel {
    private let disposeBag: DisposeBag = .init()
    private let router: Router
    
    // MARK: Data
    var title: Driver<String> = .just(L10n.NewsDetails.title)
    var newsContent: BehaviorRelay<NewsContent?> = .init(value: nil)
    
    init(router: Router) {
        self.router = router
    }
    
    deinit {
        print("DEINIT \(self)")
    }
}
