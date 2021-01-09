//
//  MockNewsService.swift
//  Dental
//
//  Created by Igor Sorokin on 18.04.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import RxSwift

final class MockNewsService: NewsService {
    
    private let mockRepository: MockRepository
    private let mapper: Mapper
    
    init(mockRepository: MockRepository, mapper: Mapper) {
        self.mockRepository = mockRepository
        self.mapper = mapper
    }
    
    func getNews(page: Int) -> Observable<News> {
        mockRepository.loadFromFile("news")
            .flatMapLatest(mapper.mapData)
    }
    
}
