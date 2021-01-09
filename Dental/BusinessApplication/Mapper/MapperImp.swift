//
//  MapperImp.swift
//  Dental
//
//  Created by Igor Sorokin on 22.03.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import RxSwift

final class MapperImp: Mapper {
    
    func mapData<Model: Codable>(
        _ data: Data,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy
    ) -> Observable<Model> {
        
        Observable<Model>.create { observable in
            let coder = JSONDecoder()
            coder.dateDecodingStrategy = dateDecodingStrategy
            coder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let object = try coder.decode(Model.self, from: data)
                observable.onNext(object)
                observable.onCompleted()
            } catch {
                observable.onError(ApiError.parsing)
            }
            
            return Disposables.create()
        }
    }
    
}
