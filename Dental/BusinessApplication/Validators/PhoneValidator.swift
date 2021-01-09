//
//  PhoneValidator.swift
//  Dental
//
//  Created by Igor Sorokin on 24.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Foundation

struct PhoneValidator: Validator {
    
    func validate(_ value: String?) -> Bool {
        guard let phone = value else {
            return false
        }
        let regEx = "^\\+79\\d{9}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: phone)

    }
    
}
