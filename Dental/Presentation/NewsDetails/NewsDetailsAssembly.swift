//
//  NewsDetailsAssembly.swift
//  Dental
//
//  Created by scar1xrd on 11/01/2020.
//  Copyright 2020 Igor Sorokin. All rights reserved.
//

import EasyDi

final class NewsDetailsAssembly: Assembly, ResolvingAssembly {
    private lazy var infrastructure: InfrastructureAssembly = context.assembly()
    
    private var view: View & ViewModelInjectable { definePlaceholder() }
    private var viewModel: NewsDetailsViewModel {
        define(init: NewsDetailsViewModelImp(router: self.infrastructure.router))
    }
    
    func inject(into view: NewsDetailsViewController) {
        defineInjection(key: "view", into: view) {
            $0.set(viewModel: self.viewModel)
            return $0
        }
    }
}

extension NewsDetailsViewController: InstantiatableAssembly {
    typealias InstantiationAssembly = NewsDetailsAssembly
}
