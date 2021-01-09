//
//  DataRequest+extension.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import RxSwift
import Alamofire

extension DataRequest {
    func validateToObservableData() -> Observable<Data> {
        return Observable.create { observable in
            self.response { (response) in
                
                if let error = response.error {
                    if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                        observable.onError(ApiError.noConnection)
                        return
                    }
                    
                    observable.onError(ApiError.server(error: error))
                    return
                }

                guard let httpResponse = response.response else {
                    observable.onError(ApiError.noData)
                    return
                }
                
                switch httpResponse.statusCode {
                case 200...205:
                    guard let data = response.data else {
                        observable.onError(ApiError.noData)
                        return
                    }
                    observable.onNext(data)
                    observable.onCompleted()
                    
                case 401:
                    observable.onError(ApiError.unauthorizedError)
                    
                case 400..<500:
                    observable.onError(ApiError.client(data: response.data))
                    
                default:
                    observable.onError(ApiError.server(error: response.error))
                }
            }
            
            return Disposables.create {
                self.cancel()
            }
        }
    }
    
    @discardableResult
    func validateResponse() -> Self {
        self.validate { (request, response, data) -> DataRequest.ValidationResult in
            
            if response.statusCode == NSURLErrorNotConnectedToInternet {
                return .failure(AFError.responseValidationFailed(
                    reason: .customValidationFailed(error: ApiError.noConnection)))
            }

            guard let data = data else {
                return .failure(AFError.responseValidationFailed(
                    reason: .customValidationFailed(error: ApiError.noData)))
            }
            
            switch response.statusCode {
            case 200...205:
                return .success(Void())
            case 401:
                return .failure(AFError.responseValidationFailed(
                    reason: .customValidationFailed(error: ApiError.unauthorizedError)))
                
            case 400..<500:
                return .failure(AFError.responseValidationFailed(
                    reason: .customValidationFailed(error: ApiError.client(data: data))))
                
            default:
                return .failure(AFError.responseValidationFailed(
                    reason: .customValidationFailed(error: ApiError.server(error: self.error))))
            }
        }
    }
    
    func observableResponse() -> Observable<Data> {
        return Observable.create { (observer) in
            self.responseData { (response) in
                
                switch response.result {
                case let .success(data):
                    observer.onNext(data)
                    observer.onCompleted()
                    
                case let .failure(error):
                    observer.onError(error)
                }
             
            }
            
            return Disposables.create {
                self.cancel()
            }
        }
    }
    
}
