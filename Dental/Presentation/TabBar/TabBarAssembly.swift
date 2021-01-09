//
//  BaseTabBarAssembly.swift
//  Dental
//
//  Created by scar1xrd on 01/03/2020.
//  Copyright 2020 Igor Sorokin. All rights reserved.
//

import EasyDi

final class TabBarAssembly: Assembly, ResolvingAssembly {
    private lazy var infrastructure: InfrastructureAssembly = context.assembly()
    private lazy var servicesFactory: ServicesFactory = context.assembly()
    
    private var view: View & ViewModelInjectable { definePlaceholder() }
    private var viewModel: TabBarViewModel {
        return define(init: TabBarViewModelImp(news: self.news, branches: self.branches))
    }
    
    // MARK: View Controllers
    var news: UIViewController {
        define(init: self.infrastructure.routingItemsFactory.routable(for: SingleModuleItem.news))
    }
    
    var branches: UIViewController {
        define(init: self.infrastructure.routingItemsFactory.routable(for: SingleModuleItem.branches))
    }
    
    func inject(into view: TabBarViewController) {
        defineInjection(key: "view", into: view) {
            $0.set(viewModel: self.viewModel)
            return $0
        }
    }
}

extension TabBarViewController: InstantiatableAssembly {
    typealias InstantiationAssembly = TabBarAssembly
}
