//
//  Observable+extension.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import RxSwift

extension Observable where Element == Data {
    func mapObject<T: Codable>() -> Observable<T> {
        flatMap { data -> Observable<T> in
            Observable<T>.create { observable in
                let coder = JSONDecoder()
                coder.dateDecodingStrategy = .iso8601
                coder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let object = try coder.decode(T.self, from: data)
                    observable.onNext(object)
                    observable.onCompleted()
                } catch {
                    observable.onError(ApiError.parsing)
                }
                
                return Disposables.create()
            }
        }
    }
}
