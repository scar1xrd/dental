//
//  MockRepositoryImp.swift
//  Dental
//
//  Created by Igor Sorokin on 18.04.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import RxSwift

final class MockRepositoryImp: MockRepository {
    
    private let bundle: Bundle
    
    init(bundle: Bundle) {
        self.bundle = bundle
    }
    
    func loadFromFile(_ fileName: String) -> Observable<Data> {
        readFile(fileName)
    }
    
    private func readFile(_ fileName: String) -> Observable<Data> {
        guard let path = self.bundle.path(forResource: fileName, ofType: "json") else {
            return .error(ApiError.noData)
        }
        
        let urlPath = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: urlPath) else {
            return .error(ApiError.parsing)
        }
        
        return .just(data)
    }
    
}
