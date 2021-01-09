//
//  Dentist.swift
//  Dental
//
//  Created by Igor Sorokin on 08.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Foundation

struct Dentist: Codable {
    let id: String
    let name: String
    let branch: [String]
    let address: String
    let education: String
    let experience: String
    let description: String
    let srcImage: String
}
