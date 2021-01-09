//
//  MockRepository.swift
//  Dental
//
//  Created by Igor Sorokin on 18.04.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import RxSwift

protocol MockRepository {
    func loadFromFile(_ fileName: String) -> Observable<Data>
}
