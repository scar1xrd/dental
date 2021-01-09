//
//  AnyPaginator.swift
//  Dental
//
//  Created by Igor Sorokin on 09.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Action
import RxCocoa
import RxSwift

private class AnyPaginatorBox<Element: Paginatable>: Paginator {
    var loadAction: Action<Void, Element>!
    var refreshAction: Action<Void, Element>!
    var loadMoreAction: Action<Int, Element>!
    var loadItemsIfNeeded: PublishRelay<Void> = .init()
    
    var elements: BehaviorRelay<([Element.Content], IndexSet?)> = .init(value: ([], nil))
    var isLoading: Bool { false }
}

private class PaginatorBox<Base: Paginator>: AnyPaginatorBox<Base.Element> {
    private let disposeBag: DisposeBag = .init()
    private var base: Base
    
    override var loadAction: Action<Void, Element>! {
        didSet {
            base.loadAction = loadAction
        }
    }
    
    override var refreshAction: Action<Void, Element>! {
        didSet {
            base.refreshAction = refreshAction
        }
    }
    
    override var loadMoreAction: Action<Int, Element>! {
        didSet {
            base.loadMoreAction = loadMoreAction
        }
    }
    
    override var isLoading: Bool { base.isLoading }
    
    init(_ base: Base) {
        self.base = base
        super.init()
        
        setup()
    }
    
    private func setup() {
        loadItemsIfNeeded
            .bind(to: base.loadItemsIfNeeded)
            .disposed(by: disposeBag)
        
        base.elements
            .bind(to: elements)
            .disposed(by: disposeBag)
    }
}

class AnyPaginator<Element: Paginatable>: Paginator {
    private let disposeBag: DisposeBag = .init()
    private let anyPaginatorBox: AnyPaginatorBox<Element>
    
    var loadAction: Action<Void, Element>! {
        didSet {
            anyPaginatorBox.loadAction = loadAction
        }
    }
    
    var refreshAction: Action<Void, Element>! {
        didSet {
            anyPaginatorBox.refreshAction = refreshAction
        }
    }
    
    var loadMoreAction: Action<Int, Element>! {
        didSet {
            anyPaginatorBox.loadMoreAction = loadMoreAction
        }
    }
    
    var loadItemsIfNeeded: PublishRelay<Void> = .init()
     
    var elements: BehaviorRelay<([Element.Content], IndexSet?)> = .init(value: ([], nil))
    var isLoading: Bool { anyPaginatorBox.isLoading }
    
    init<PaginatorType: Paginator>(_ paginator: PaginatorType)
        where PaginatorType.Element == Element {
            anyPaginatorBox = PaginatorBox(paginator)
            
            setup()
    }
    
    private func setup() {
        loadItemsIfNeeded
            .bind(to: anyPaginatorBox.loadItemsIfNeeded)
            .disposed(by: disposeBag)
        
        anyPaginatorBox.elements
            .bind(to: elements)
            .disposed(by: disposeBag)
    }
    
}
