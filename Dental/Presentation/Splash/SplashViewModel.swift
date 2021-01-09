//
//  SplashViewModel.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

protocol SplashViewModel: ViewModel {
    
}

class SplashViewModelImp: SplashViewModel {
    private let disposeBag: DisposeBag = .init()
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    deinit {
        print("DEINIT \(self)")
    }
}
