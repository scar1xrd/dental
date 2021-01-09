//
//  InternalRepository.swift
//  Dental
//
//  Created by Igor Sorokin on 01.03.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import Foundation

public protocol InternalRepository {
    func set(_ value: Any?, forKey defaultName: String)
    func object(forKey defaultName: String) -> Any?
    func removeObject(forKey defaultName: String)
}
