//
//  AppointmentFormViewModel.swift
//  Dental
//
//  Created by scar1xrd on 16/02/2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

protocol AppointmentFormViewModel: ViewModel, Configurable {
    var name: BehaviorRelay<String?> { get }
    var bornday: BehaviorRelay<String?> { get }
    var phone: BehaviorRelay<String?> { get }
    var date: BehaviorRelay<String?> { get }
    
    var nameValid: BehaviorRelay<Bool> { get }
    var borndayValid: BehaviorRelay<Bool> { get }
    var phoneValid: BehaviorRelay<Bool> { get }
    
    var sendAppointmentAction: Action<Void, Void>! { get }
    func closeForm()
    func closeFormAndPopToRoot()
}

class AppointmentFormViewModelImp: AppointmentFormViewModel {
    private let disposeBag: DisposeBag = .init()
    private let router: Router
    private let receptionService: ReceptionService
    
    // MARK: Data
    var name: BehaviorRelay<String?> = .init(value: nil)
    var bornday: BehaviorRelay<String?> = .init(value: nil)
    var phone: BehaviorRelay<String?> = .init(value: nil)
    var date: BehaviorRelay<String?> = .init(value: nil)
    
    // MARK: Actions
    var sendAppointmentAction: Action<Void, Void>!
    
    // MARK: Helpers
    var nameValid: BehaviorRelay<Bool> = .init(value: false)
    var borndayValid: BehaviorRelay<Bool> = .init(value: false)
    var phoneValid: BehaviorRelay<Bool> = .init(value: false)
    
    var emptyValidator: Validator
    var phoneValidator: Validator
    
    init(
        router: Router,
        receptionService: ReceptionService,
        emptyValidator: Validator,
        phoneValidator: Validator
    ) {
        self.router = router
        self.receptionService = receptionService
        
        self.emptyValidator = emptyValidator
        self.phoneValidator = phoneValidator
        
        setupActions()
        setupHelpers()
    }
    
    deinit {
        print("DEINIT \(self)")
    }
    
    func closeFormAndPopToRoot() {
        router.dismissModal(animated: true) { [weak self] in
            self?.router.closeAllInStack()
        }
    }
    
    func closeForm() {
        router.dismissModal()
    }
    
    private func setupActions() {
        sendAppointmentAction = Action { [unowned self] in
            guard self.nameValid.value else { return .error(FormError.wrongName) }
            guard self.borndayValid.value else { return .error(FormError.wrongBornday) }
            guard self.phoneValid.value else { return .error(FormError.wrongPhone) }
            guard let date = self.date.value else { return .error(FormError.undefine) }
            
            return self.receptionService.sendAppointment(
                name: self.name.value ?? "",
                bornday: self.bornday.value ?? "",
                phone: self.phone.value?.removePhoneMask() ?? "",
                timetableId: date
            )
        }
    }
    
    private func setupHelpers() {
        name.map(emptyValidator.validate)
            .bind(to: nameValid)
            .disposed(by: disposeBag)
        
        bornday.map(emptyValidator.validate)
            .bind(to: borndayValid)
            .disposed(by: disposeBag)
        
        phone.map { $0?.removePhoneMask() }
             .map(phoneValidator.validate)
             .bind(to: phoneValid)
             .disposed(by: disposeBag)
    }
    
}
