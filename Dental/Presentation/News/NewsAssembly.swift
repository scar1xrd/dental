//
//  NewsAssembly.swift
//  Dental
//
//  Created by scar1xrd on 06/01/2020.
//  Copyright 2020 Igor Sorokin. All rights reserved.
//

import EasyDi

final class NewsAssembly: Assembly, ResolvingAssembly {
    private lazy var infrastructure: InfrastructureAssembly = context.assembly()
    private lazy var servicesFactory: ServicesFactory = context.assembly()
    private lazy var paginatorFactory: PaginatorFactory<News> = context.assembly()
    
    private var view: View & ViewModelInjectable { definePlaceholder() }
    private var viewModel: NewsViewModel {
        define(init: NewsViewModelImp(
            router: self.infrastructure.router,
            newsService: self.servicesFactory.newsService,
            paginator: self.paginatorFactory.paginatorService
        ))
    }
    
    func inject(into view: NewsViewController) {
        defineInjection(key: "view", into: view) {
            $0.set(viewModel: self.viewModel)
            return $0
        }
    }
}

extension NewsViewController: InstantiatableAssembly {
    typealias InstantiationAssembly = NewsAssembly
}
