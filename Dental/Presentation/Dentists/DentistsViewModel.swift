//
//  DentistsViewModel.swift
//  Dental
//
//  Created by scar1xrd on 08/02/2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

protocol DentistsViewModel: ViewModel, Configurable {
    var branch: String? { get set }
    var title: Driver<String> { get }
    var addressDentistsSection: BehaviorRelay<[AddressDentistsSection]?> { get }
    
    var loadDentists: Action<Void, [AddressDentists]>! { get }
    func showDentist(_ dentist: Dentist)
}

class DentistsViewModelImp: DentistsViewModel {
    private let disposeBag: DisposeBag = .init()
    private let router: Router
    private let receptionService: ReceptionService
    
    // MARK: Data
    var addressDentistsSection: BehaviorRelay<[AddressDentistsSection]?> = .init(value: nil)
    var title: Driver<String> = .just(L10n.Dentists.title)
    var branch: String?
    
    // MARK: Actions
    var loadDentists: Action<Void, [AddressDentists]>!
    
    init(router: Router, receptionService: ReceptionService) {
        self.router = router
        self.receptionService = receptionService
        
        setupActions()
    }
    
    deinit {
        print("DEINIT \(self)")
    }
    
    func showDentist(_ dentist: Dentist) {
        router.show(SingleModuleItem.dentistDetails) { configurable in
            guard let dentistDetailsViewModel = configurable as? DentistDetailsViewModel else { return }
            dentistDetailsViewModel.dentist = dentist
        }
    }
    
    private func setupActions() {
        loadDentists = Action { [unowned self] in
            self.receptionService.getDentistsForBranch(self.branch ?? "")
                .do(onNext: self.handleResponse(_:))
        }
    }
    
    private func handleResponse(_ addrDentists: [AddressDentists]) {
        var addressDentistsSection: [AddressDentistsSection] = []
        
        addrDentists.forEach {
            let section = AddressDentistsSection(header: $0.address, items: $0.dentists, footer: nil)
            addressDentistsSection.append(section)
        }
        
        self.addressDentistsSection.accept(addressDentistsSection)
    }
    
}
