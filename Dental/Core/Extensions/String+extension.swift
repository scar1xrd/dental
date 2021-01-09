//
//  String+extension.swift
//  Dental
//
//  Created by Igor Sorokin on 24.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Foundation

extension String {
    
    init(age: Int) {
        
        let lastDigit = age % 10
        
        if lastDigit == 1 {
            self = "\(age) год"
            return
        } else if lastDigit == 2 || lastDigit == 3 || lastDigit == 4 {
            self = "\(age) года"
        } else {
            self = "\(age) лет"
        }
        
    }
    
    func removePhoneMask() -> String {
        let mask: Set<Character> = [" ", "-", "(", ")"]
        var string = self
        string.removeAll(where: mask.contains)
        return string
    }
    
}
