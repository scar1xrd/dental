//
//  PasswordValidator.swift
//  Dental
//
//  Created by Igor Sorokin on 07.03.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Foundation

struct PasswordValidator: Validator {
    
    func validate(_ value: String?) -> Bool {
        let regEx = "^.{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: value)
    }
    
}
