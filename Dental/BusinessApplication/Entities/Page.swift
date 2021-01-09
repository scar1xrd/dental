//
//  Page.swift
//  Dental
//
//  Created by Igor Sorokin on 07.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Foundation

protocol Paginatable {
    associatedtype Content
    var max: Int { get }
    var current: Int { get }
    var data: [Content] { get }
}

struct Page: Codable {
    let position: PagePosition
    let data: PageData
}

struct PagePosition: Codable {
    let current: Int
    let max: Int
}

struct PageData: Codable {
    let per: Int
    let total: Int
}
