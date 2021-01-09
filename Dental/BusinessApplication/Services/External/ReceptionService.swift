//
//  ReceptionService.swift
//  Dental
//
//  Created by Igor Sorokin on 07.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import RxSwift
import Alamofire

protocol ReceptionService {
    func getAllBranches() -> Observable<[Branch]>
    func getDentistsForBranch(_ branch: String) -> Observable<[AddressDentists]>
    func getAvailableTimeForDentist(_ dentistId: String) -> Observable<DentistTimetable>
    func sendAppointment(
        name: String,
        bornday: String,
        phone: String,
        timetableId: String
    ) -> Observable<Void>
}

final class ReceptionServiceImp: ReceptionService {
    private let externalRepository: ExternalRepository
    private let mapper: Mapper
    
    init(externalRepository: ExternalRepository, mapper: Mapper) {
        self.externalRepository = externalRepository
        self.mapper = mapper
    }
    
    func getAllBranches() -> Observable<[Branch]> {
        let url = URLBuilder.urlFrom(path: Constants.Paths.branches).getUrl()
        return externalRepository.sendRequest(url, method: .get)
            .flatMapLatest(mapper.mapData)
    }
    
    func getDentistsForBranch(_ branch: String) -> Observable<[AddressDentists]> {
        let url = URLBuilder.urlFromPathAndQuery(
            path: Constants.Paths.dentists,
            query: ["branch": branch]
        ).getUrl()
        
        return externalRepository.sendRequest(url, method: .get)
            .flatMapLatest(mapper.mapData)
    }
    
    func getAvailableTimeForDentist(_ dentistID: String) -> Observable<DentistTimetable> {
        let url = URLBuilder.urlFrom(path: Constants.Paths.dentistTimetable + dentistID).getUrl()
        return externalRepository.sendRequest(url, method: .get)
            .flatMapLatest(mapper.mapData)
    }
    
    func sendAppointment(
        name: String,
        bornday: String,
        phone: String,
        timetableId: String
    ) -> Observable<Void> {
        let url = URLBuilder.urlFrom(path: Constants.Paths.dentistTimetable).getUrl()
        
        let params: Parameters = [
            "name": name,
            "bornday": bornday,
            "phone": phone,
            "timetableID": timetableId
        ]
        
        return externalRepository.sendRequest(url, method: HTTPMethod.post, parameters: params)
            .flatMapLatest { input -> Observable<Void> in
                .just(())
            }
    }
}
