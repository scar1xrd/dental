//
//  DentistDetailsViewModel.swift
//  Dental
//
//  Created by scar1xrd on 16/02/2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

protocol DentistDetailsViewModel: ViewModel, Configurable {
    var dentist: Dentist? { get set }
    var selectedDate: BehaviorRelay<String?> { get }
    
    func closeController()
    func showTimetable()
}

class DentistDetailsViewModelImp: DentistDetailsViewModel {
    private let disposeBag: DisposeBag = .init()
    private let router: Router
    
    // MARK: Data
    var dentist: Dentist?
    var selectedDate: BehaviorRelay<String?> = .init(value: nil)
    
    init(router: Router) {
        self.router = router
        
        setupSelectedDateHandler()
    }
    
    deinit {
        print("DEINIT \(self)")
    }
    
    func showTimetable() {
        router.show(ModalModuleItem.timetable) { [weak self] configurable in
            guard
                let self = self,
                let dentistTimetableViewModel = configurable as? DentistTimetableViewModel
                else { return }
            
            dentistTimetableViewModel.dentistId = self.dentist?.id
            dentistTimetableViewModel.selectedDate.bind(to: self.selectedDate).disposed(by: self.disposeBag)
        }
    }
    
    func closeController() {
        router.close()
    }
    
    private func setupSelectedDateHandler() {
        selectedDate
            .subscribe(onNext: { [unowned self] (date) in
                guard let date = date else { return }
                self.handleSeletedDate(date)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleSeletedDate(_ date: String) {
        router.dismissModal { [unowned self] in
            self.router.show(ModalModuleItem.appointmentForm, animated: true) { (configurable) in
                guard let appointmentViewModel = configurable as? AppointmentFormViewModel else { return }
                appointmentViewModel.date.accept(date)
            }
        }
    }
    
}
