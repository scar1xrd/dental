//
//  Constants.swift
//  Dental
//
//  Created by Igor Sorokin on 06.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Foundation

enum Constants {
    
    enum Api {
        static let scheme: String = "http"
        static let host: String = "localhost"
        static let baseURL: String = "/api/v1/"
        static let port: Int? = 8080
    }
    
    enum Paths {
        static let news: String = "articles"
        static let branches: String = "dentists/branches"
        static let dentists: String = "dentists/address"
        static let dentistTimetable = "dentists/timetable/"
        static let login: String = "users/login"
        static let users: String = "users"
    }
}
