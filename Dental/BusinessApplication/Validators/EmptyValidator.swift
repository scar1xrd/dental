//
//  AgeValidator.swift
//  Dental
//
//  Created by Igor Sorokin on 24.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Foundation

struct EmptyValidator: Validator {
    
    func validate(_ value: String?) -> Bool {
        guard let value = value, !value.isEmpty else {
            return false
        }
        return true
    }
    
}
