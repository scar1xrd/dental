//
//  DentistTimetableAssembly.swift
//  Dental
//
//  Created by Igor Sorokin on 16.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import EasyDi

final class DentistTimetableAssembly: Assembly, ResolvingAssembly {
    private lazy var infrastructure: InfrastructureAssembly = context.assembly()
    private lazy var servicesFactory: ServicesFactory = context.assembly()
    
    var view: View & ViewModelInjectable { definePlaceholder() }
    
    private var viewModel: DentistTimetableViewModel {
        define(init: DentistTimetableViewModelImp(
            router: self.infrastructure.router,
            receptionService: self.servicesFactory.receptionService
        ))
    }
    
    func inject(into view: DentistTimetableViewController) {
        defineInjection(key: "view", into: view) {
            $0.set(viewModel: self.viewModel)
            return $0
        }
    }
}

extension DentistTimetableViewController: InstantiatableAssembly {
    typealias InstantiationAssembly = DentistTimetableAssembly
}
