//
//  DentistTimetableViewModel.swift
//  Dental
//
//  Created by scar1xrd on 16/02/2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

protocol DentistTimetableViewModel: ViewModel, Configurable {
    var dentistId: String? { get set }
    var selectedDate: BehaviorRelay<String?> { get }
    var dentistTimetable: BehaviorRelay<[DentistTimes]?> { get }
    
    var loadDentistTimetable: Action<Void, DentistTimetable>? { get }
}

class DentistTimetableViewModelImp: DentistTimetableViewModel {
    private let disposeBag: DisposeBag = .init()
    private let router: Router
    private let receptionService: ReceptionService
    
    // MARK: Data
    var dentistTimetable: BehaviorRelay<[DentistTimes]?> = .init(value: nil)
    var selectedDate: BehaviorRelay<String?> = .init(value: nil)
    
    var dentistId: String? {
        didSet {
            loadDentistTimetable?.execute()
        }
    }
    
    // MARK: Actions
    var loadDentistTimetable: Action<Void, DentistTimetable>?
    
    init(router: Router, receptionService: ReceptionService) {
        self.router = router
        self.receptionService = receptionService
        
        setupActions()
    }
    
    deinit {
        print("DEINIT \(self)")
    }
    
    private func setupActions() {
        loadDentistTimetable = Action { [unowned self] in
            self.receptionService.getAvailableTimeForDentist(self.dentistId ?? "")
                .do(onNext: self.handleTimetable(_:))
        }
    }
    
    private func handleTimetable(_ timetable: DentistTimetable) {
        let availableTime = timetable.availableTime
        var sortedTime: [DentistTimes] = []
        var days: [Date: DentistTimes] = [:]
        
        availableTime.forEach {
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .calendar], from: $0.date)
            guard let day = dateComponents.date else { return }
            
            if days.keys.contains(day) {
                days[day]?.originalTime.append($0)
            } else {
                let dentTimes = DentistTimes(day: day, originalTime: [$0])
                days[day] = dentTimes
            }
        }
        
        days.keys.sorted().forEach {
            guard let time = days[$0] else { return }
            sortedTime.append(time)
        }
        
        self.dentistTimetable.accept(sortedTime)
    }
    
}
