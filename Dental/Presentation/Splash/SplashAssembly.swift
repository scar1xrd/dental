//
//  SplashAssembly.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import EasyDi

final class SplashAssembly: Assembly, ResolvingAssembly {
    private lazy var infrastructure: InfrastructureAssembly = context.assembly()
    
    private var view: SplashView & ViewModelInjectable { definePlaceholder() }
    private var viewModel: SplashViewModel {
        define(init: SplashViewModelImp(router: self.infrastructure.router))
    }
    
    func inject(into view: SplashViewController) {
        defineInjection(key: "view", into: view) {
            $0.set(viewModel: self.viewModel)
            return $0
        }
    }
}

extension SplashViewController: InstantiatableAssembly {
    typealias InstantiationAssembly = SplashAssembly
}
