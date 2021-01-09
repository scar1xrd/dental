//
//  DentistDetailsAssembly.swift
//  Dental
//
//  Created by scar1xrd on 16/02/2020.
//  Copyright 2020 Igor Sorokin. All rights reserved.
//

import EasyDi

final class DentistDetailsAssembly: Assembly, ResolvingAssembly {
    private lazy var infrastructure: InfrastructureAssembly = context.assembly()
    
    private var view: View & ViewModelInjectable { definePlaceholder() }
    private var viewModel: DentistDetailsViewModel {
        return define(init: DentistDetailsViewModelImp(router: self.infrastructure.router))
    }
    
    func inject(into view: DentistDetailsViewController) {
        defineInjection(key: "view", into: view) {
            $0.set(viewModel: self.viewModel)
            return $0
        }
    }
}

extension DentistDetailsViewController: InstantiatableAssembly {
    typealias InstantiationAssembly = DentistDetailsAssembly
}
