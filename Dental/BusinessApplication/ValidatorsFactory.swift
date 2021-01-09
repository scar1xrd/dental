//
//  ValidatorsFactory.swift
//  Dental
//
//  Created by Igor Sorokin on 24.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import EasyDi

final class ValidatorsFactory: Assembly {
    
    var emptyValidator: Validator { define(init: EmptyValidator() )}
    
    var phoneValidator: Validator { define(init: PhoneValidator() )}
    
}
