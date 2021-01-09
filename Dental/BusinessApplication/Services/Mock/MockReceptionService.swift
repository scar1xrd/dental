//
//  MockReceptionService.swift
//  Dental
//
//  Created by Igor Sorokin on 18.04.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import RxSwift

final class MockReceptionService: ReceptionService {
    
    private let mockRepository: MockRepository
    private let mapper: Mapper
    
    init(mockRepository: MockRepository, mapper: Mapper) {
        self.mockRepository = mockRepository
        self.mapper = mapper
    }
    
    func getAllBranches() -> Observable<[Branch]> {
        mockRepository.loadFromFile("branches")
            .flatMapLatest(mapper.mapData)
    }
    
    func getDentistsForBranch(_ branch: String) -> Observable<[AddressDentists]> {
        mockRepository.loadFromFile("dentists")
            .flatMapLatest(mapper.mapData)
    }
    
    func getAvailableTimeForDentist(_ dentistId: String) -> Observable<DentistTimetable> {
        mockRepository.loadFromFile("timetable")
            .flatMapLatest(mapper.mapData)
    }
    
    func sendAppointment(
        name: String,
        bornday: String,
        phone: String,
        timetableId: String
    ) -> Observable<Void> {
        .just(())
    }
    
}
