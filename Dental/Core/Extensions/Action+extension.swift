//
//  Actions+extension.swift
//  Dental
//
//  Created by Igor Sorokin on 11.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Action
import RxSwift

extension Action {
    func onElements(action: @escaping (Element) -> Void) -> Disposable {
        self.elements
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: action)
    }
    
    func onApiErrors(action: @escaping (ApiError) -> Void) -> Disposable {
        self.errors
            .observeOn(MainScheduler.instance)
            .map(ErrorManager.toApiError)
            .subscribe(onNext: { (error) in
                action(error)
            })
    }
    
    func onExecuting(
        executingAction: (() -> Void)?,
        nonExecutingAction: (() -> Void)?
    ) -> Disposable {
        self.executing
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (isExecuting) in
                isExecuting ? executingAction?() : nonExecutingAction?()
            })
    }
}
