//
//  ExternalRepositoryImp.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import Alamofire
import RxSwift

final class ExternalRepositoryImp: ExternalRepository {
    private let sessionManager: Session
    
    init(session: Session) {
        self.sessionManager = session
    }
    
    func sendRequest(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: [String: String]? = nil,
        interceptor: RequestInterceptor? = nil
    ) -> Observable<Data> {
        
        sessionManager.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: .init(headers ?? [:]),
            interceptor: interceptor
        )
            .validateToObservableData()
    }
    
}
