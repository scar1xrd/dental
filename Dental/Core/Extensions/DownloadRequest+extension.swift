//
//  DownloadRequest+extension.swift
//  Dental
//
//  Created by Igor Sorokin on 22.03.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Alamofire
import RxSwift

extension DownloadRequest {
    
    func validateToObservableData() -> Observable<Data> {
        return Observable.create { observable in
            self.responseData { (response) in
                
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
                    guard let data = response.value else {
                        observable.onError(ApiError.noData)
                        return
                    }
                    observable.onNext(data)
                    observable.onCompleted()
                    
                case 401:
                    observable.onError(ApiError.unauthorizedError)
                    
                case 400..<500:
                    observable.onError(ApiError.client(data: response.value))
                    
                default:
                    observable.onError(ApiError.server(error: response.error))
                }
            }
            
            return Disposables.create {
                self.cancel()
            }
        }
    }
    
}
