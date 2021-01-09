//
//  Paginator.swift
//  Dental
//
//  Created by Igor Sorokin on 07.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

final class PaginatorImp<Element: Paginatable>: Paginator {
    
    // MARK: Private properties
    private let disposeBag: DisposeBag = .init()
    private var pagesCount: Int = 1
    private var page: Int = 1
    
    // MARK: Public properties
    var isLoading: Bool = false
    
    // MARK: Data
    /// First item in tuple - Element.Content (your model data)
    /// Second item in tuple - updatable range for insert rows
    var elements: BehaviorRelay<([Element.Content], IndexSet?)> = .init(value: ([], nil))
    
    // MARK: Actions
    var loadAction: Action<Void, Element>! {
        didSet {
            loadAction.elements
                .subscribe(onNext: { (element) in
                    self.pagesCount = element.max
                    self.page = element.current
                    self.elements.accept((element.data, nil))
                    self.isLoading = false
                })
                .disposed(by: disposeBag)
        }
    }

    var refreshAction: Action<Void, Element>! {
        didSet {
            refreshAction.elements
                .subscribe(onNext: { (element) in
                    self.pagesCount = element.max
                    self.page = element.current
                    self.elements.accept((element.data, nil))
                    self.isLoading = false
                })
                .disposed(by: disposeBag)
        }
    }
    var loadMoreAction: Action<Int, Element>! {
        didSet {
            loadMoreAction.elements
                .subscribe(onNext: { (element) in
                    let currentContent = self.elements.value.0
                    let newContent = element.data

                    let updatedElementsData = currentContent + newContent
                    let updatedRange = IndexSet(currentContent.count ..< (currentContent.count + newContent.count))

                    self.elements.accept((updatedElementsData, updatedRange))
                    self.isLoading = false
                })
                .disposed(by: disposeBag)
        }
    }
    
    var loadItemsIfNeeded: PublishRelay<Void> = .init()
    
    init() {
        setup()
    }
    
    deinit {
        print("DEINIT \(self)")
    }
    
    private func setup() {
        loadItemsIfNeeded
            .throttle(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (element) in
                guard !self.isLoading, self.page < self.pagesCount else { return }
                self.isLoading = true
                self.page += 1
                self.loadMoreAction.execute(self.page)
            })
            .disposed(by: disposeBag)
    }
    
}
