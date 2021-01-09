//
//  SplashService.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import RxSwift
import Alamofire

protocol SplashService {
    func getSplashInfo() -> Observable<SplashModel>
}

final class SplashServiceImp: SplashService {
    private let externalRepository: ExternalRepository
    private let mapper: Mapper
    
    init(externalRepository: ExternalRepository, mapper: Mapper) {
        self.externalRepository = externalRepository
        self.mapper = mapper
    }
    
    func getSplashInfo() -> Observable<SplashModel> {
        let url = URLBuilder.urlFrom(path: "path").getUrl()
        let headers: [String: String] = [
            "header": "header"
        ]
        
        return externalRepository.sendRequest(url, method: .get, headers: headers)
            .flatMapLatest(mapper.mapData)
    }
}
