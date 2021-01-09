//
//  Paginator.swift
//  Dental
//
//  Created by Igor Sorokin on 09.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Action
import RxCocoa

protocol Paginator {
    associatedtype Element: Paginatable
    
    var isLoading: Bool { get }
    
    // MARK: Actions
    var loadAction: Action<Void, Element>! { get set }
    var refreshAction: Action<Void, Element>! { get set }
    var loadMoreAction: Action<Int, Element>! { get set }
    var loadItemsIfNeeded: PublishRelay<Void> { get }
    
    // MARK: Data
    var elements: BehaviorRelay<([Element.Content], IndexSet?)> { get }
}
