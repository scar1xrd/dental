//
//  News.swift
//  Dental
//
//  Created by Igor Sorokin on 06.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Foundation
import RxDataSources

struct News: Codable {
    let data: [NewsContent]
    let page: Page
}

extension News: Paginatable {
    typealias Content = NewsContent
    var current: Int { page.position.current }
    var max: Int { page.position.max }
}

struct NewsContent: Codable {
    let id: String
    let title: String
    let content: String
    let srcImage: String
    let createdDate: String
}

// MARK: AnimatableSectionModelType
extension NewsContent: IdentifiableType, Equatable {
    typealias Identity = String
    
    var identity: String { id }
}

typealias NewsSectionModel = AnimatableSectionModel<Int, NewsContent>
