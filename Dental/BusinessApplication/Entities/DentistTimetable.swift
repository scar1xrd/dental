//
//  DentistTimetable.swift
//  Dental
//
//  Created by Igor Sorokin on 16.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Foundation

struct DentistTimetable: Codable {
    let dentistId: String?
    let availableTime: [AvailableTime]
}

struct AvailableTime: Codable {
    let date: Date
    let id: String?
    let isReserved: Bool
    let dentistId: String?
    
    var dayDisplay: String {
        DateFormatter.defaulDateFormatter.string(from: date)
    }
    
    var timeDisplay: String {
        DateFormatter.timeDateFormatter.string(from: date)
    }
}

struct DentistTimes {
    let day: Date
    var originalTime: [AvailableTime]
}
