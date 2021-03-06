//
//  BranchesAssembly.swift
//  Dental
//
//  Created by scar1xrd on 01/02/2020.
//  Copyright 2020 Igor Sorokin. All rights reserved.
//

import EasyDi

final class BranchesAssembly: Assembly, ResolvingAssembly {
    private lazy var infrastructure: InfrastructureAssembly = context.assembly()
    private lazy var servicesFactory: ServicesFactory = context.assembly()
    
    private var view: View & ViewModelInjectable { definePlaceholder() }
    private var viewModel: BranchesViewModel {
        define(init: BranchesViewModelImp(
            router: self.infrastructure.router,
            receptionService: self.servicesFactory.receptionService
        ))
    }
    
    func inject(into view: BranchesViewController) {
        defineInjection(key: "view", into: view) {
            $0.set(viewModel: self.viewModel)
            return $0
        }
    }
}

extension BranchesViewController: InstantiatableAssembly {
    typealias InstantiationAssembly = BranchesAssembly
}
