//
//  AddressDentists.swift
//  Dental
//
//  Created by Igor Sorokin on 08.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Foundation

struct AddressDentistsSection: TableViewSection {
    typealias HeaderModel = String?
    typealias Item = Dentist
    typealias FooterModel = Any?
    
    var header: String?
    var items: [Dentist]
    var footer: Any?
}

struct AddressDentists: Codable {
    let address: String
    let dentists: [Dentist]
}
