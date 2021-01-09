//
//  AppointmentFormAssembly.swift
//  Dental
//
//  Created by scar1xrd on 16/02/2020.
//  Copyright 2020 Igor Sorokin. All rights reserved.
//

import EasyDi

final class AppointmentFormAssembly: Assembly, ResolvingAssembly {
    private lazy var infrastructure: InfrastructureAssembly = context.assembly()
    private lazy var servicesFactory: ServicesFactory = context.assembly()
    private lazy var validatorsFactory: ValidatorsFactory = context.assembly()
    
    private var view: View & ViewModelInjectable { definePlaceholder() }
    private var viewModel: AppointmentFormViewModel {
        define(init: AppointmentFormViewModelImp(
            router: self.infrastructure.router,
            receptionService: self.servicesFactory.receptionService,
            emptyValidator: self.validatorsFactory.emptyValidator,
            phoneValidator: self.validatorsFactory.phoneValidator
        ))
    }
    
    func inject(into view: AppointmentFormViewController) {
        defineInjection(key: "view", into: view) {
            $0.set(viewModel: self.viewModel)
            return $0
        }
    }
}

extension AppointmentFormViewController: InstantiatableAssembly {
    typealias InstantiationAssembly = AppointmentFormAssembly
}
