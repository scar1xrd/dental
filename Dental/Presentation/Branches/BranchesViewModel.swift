//
//  BranchesViewModel.swift
//  Dental
//
//  Created by scar1xrd on 01/02/2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

protocol BranchesViewModel: ViewModel {
    var title: Driver<String> { get }
    var branchesSection: BehaviorRelay<[BranchSection]?> { get }
    
    var loadBranches: Action<Void, [Branch]>! { get }
    func showDentistsForBranch(_ branch: String)
}

class BranchesViewModelImp: BranchesViewModel {
    private let disposeBag: DisposeBag = .init()
    private let router: Router
    private let receptionService: ReceptionService
    
    // MARK: Data
    var title: Driver<String> = .just(L10n.Branches.title)
    var branchesSection: BehaviorRelay<[BranchSection]?> = .init(value: nil)
    
    // MARK: Actions
    var loadBranches: Action<Void, [Branch]>!
    
    init(router: Router, receptionService: ReceptionService) {
        self.router = router
        self.receptionService = receptionService
        
        setupActions()
    }
    
    deinit {
        print("DEINIT \(self)")
    }
    
    func showDentistsForBranch(_ branch: String) {
        router.show(SingleModuleItem.dentists) { (configurable) in
            guard let dentistsViewModel = configurable as? DentistsViewModel else { return }
            dentistsViewModel.branch = branch
        }
    }
    
    private func setupActions() {
        loadBranches = Action { [unowned self] in
            self.receptionService.getAllBranches()
                .do(onNext: { [unowned self] (branches) in
                    let branchesSection = BranchSection(header: nil, items: branches, footer: nil)
                    self.branchesSection.accept([branchesSection])
                })
        }
    }
    
}
