//
//  URLHelper.swift
//  Dental
//
//  Created by Igor Sorokin on 28.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import Alamofire

enum URLBuilder {
    case urlFrom(path: String)
    case urlFromPathAndQuery(path: String, query: [String: String])
    case urlFromPathQueryAndBaseURL(path: String, query: [String: String], baseURL: String)
    
    func getUrl() -> URL {
        switch self {
        case .urlFrom(path: let path):
            return self.build(path: path)
        case .urlFromPathAndQuery(path: let path, query: let query):
            return self.build(path: path, queryItemsString: query)
        case let .urlFromPathQueryAndBaseURL(path: path, query: query, baseURL: baseURL):
            return self.build(path: path, queryItemsString: query, baseURL: baseURL)
        }
    }
    
    private func build(
        for scheme: String = Constants.Api.scheme,
        host: String = Constants.Api.host,
        port: Int? = Constants.Api.port,
        path: String,
        queryItemsString: [String: String]? = nil,
        baseURL: String = Constants.Api.baseURL
    ) -> URL {
        var components = URLComponents.init()
        
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = baseURL + path
        
        if let queryItemsString = queryItemsString {
            var queryItems = [URLQueryItem]()
            queryItems.append(contentsOf: queryItemsString.compactMap { (key, value) -> URLQueryItem in
                return URLQueryItem.init(name: key, value: value)
            })
            components.queryItems = queryItems
        }
        
        return components.url!
    }
}
