//
//  NewsService.swift
//  Dental
//
//  Created by Igor Sorokin on 06.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import RxSwift
import Alamofire

protocol NewsService {
    func getNews(page: Int) -> Observable<News>
}

final class NewsServiceImp: NewsService {
    private let externalRepository: ExternalRepository
    private let mapper: Mapper
    
    init(externalRepository: ExternalRepository, mapper: Mapper) {
        self.externalRepository = externalRepository
        self.mapper = mapper
    }
    
    func getNews(page: Int) -> Observable<News> {
        let url = URLBuilder.urlFrom(path: Constants.Paths.news).getUrl()
        let params: Parameters = [
            "page": page,
            "per": 10
        ]
        
        return externalRepository.sendRequest(url, method: .get, parameters: params)
            .flatMapLatest(mapper.mapData)
    }
}
