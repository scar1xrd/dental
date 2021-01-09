//
//  DateFormatter.swift
//  Dental
//
//  Created by Igor Sorokin on 16.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let isoFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }()
    
    static let defaulDateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter
    }()
    
    static let timeDateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter
    }()
    
}
