//
//  Validators.swift
//  Dental
//
//  Created by Igor Sorokin on 24.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

protocol Validator {
    func validate(_ value: String?) -> Bool
}
