//
//  ErrorManager.swift
//  Dental
//
//  Created by Igor Sorokin on 16.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Action

class ErrorManager {
    
    static func isFormError(actionError: ActionError) -> Bool {
        switch actionError {
        case .underlyingError(let error):
            return (error as? FormError) != nil ? true : false
        default:
            return false
        }
    }
    
    static func toFormError(actionError: ActionError) -> FormError {
        switch actionError {
        case .underlyingError(let error):
            if let error = error as? FormError {
                return error
            }
            return FormError.undefine
        default:
            return FormError.undefine
        }
    }
    
    static func toApiError(actionError: ActionError) -> ApiError {
        switch actionError {
        case .underlyingError(let error):
            if let error = error as? ApiError {
                return error
            }
            return ApiError.unknown
        default:
            return ApiError.unknown
        }
    }
    
    static func isServerError(actionError: ActionError) -> Bool {
        let apiError = ErrorManager.toApiError(actionError: actionError)
        if case ApiError.server(_) = apiError {
            return true
        } else {
            return false
        }
    }
    
}
