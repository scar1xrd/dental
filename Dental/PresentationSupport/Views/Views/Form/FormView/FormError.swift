//
//  FormError.swift
//  Dental
//
//  Created by Igor Sorokin on 22.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Foundation

enum FormError: Swift.Error, LocalizedError {
    case wrongName
    case wrongBornday
    case wrongPhone
    case wrongPassword
    case undefine
    
    var errorDescription: String? {
        switch self {
        case .wrongName:     return L10n.Form.nameError
        case .wrongBornday:  return L10n.Form.borndayError
        case .wrongPhone:    return L10n.Form.phoneError
        case .wrongPassword: return L10n.Form.passwordError
        case .undefine:      return L10n.Form.undefinedError
        }
    }
    
}
