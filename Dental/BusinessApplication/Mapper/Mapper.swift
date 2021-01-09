//
//  Mapper.swift
//  Dental
//
//  Created by Igor Sorokin on 22.03.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import RxSwift

protocol Mapper {
    func mapData<Model: Codable>(
        _ data: Data,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy
    ) -> Observable<Model>
}

extension Mapper {
    func mapData<Model: Codable>(_ data: Data) -> Observable<Model> {
        mapData(data, dateDecodingStrategy: .iso8601)
    }
}
