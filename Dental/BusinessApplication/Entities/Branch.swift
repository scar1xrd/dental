//
//  Branch.swift
//  Dental
//
//  Created by Igor Sorokin on 07.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Foundation

struct BranchSection: TableViewSection {
    typealias HeaderModel = Any?
    typealias Item = Branch
    typealias FooterModel = Any?
    
    var header: Any?
    var items: [Branch]
    var footer: Any?
}

struct Branch: Codable {
    let branchName: String
    let description: String
    let srcImage: String
}
