//
//  ExternalRepository.swift
//  Dental
//
//  Created by Igor Sorokin on 01.03.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Alamofire
import RxSwift

protocol ExternalRepository {
    //swiftlint:disable function_parameter_count
    func sendRequest(
        _ url: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        headers: [String: String]?,
        interceptor: RequestInterceptor?
    ) -> Observable<Data>
    
}

extension ExternalRepository {
    func sendRequest(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: [String: String]? = nil,
        interceptor: RequestInterceptor? = nil
    ) -> Observable<Data> {
        
        self.sendRequest(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers,
            interceptor: interceptor
        )
        
    }
}
