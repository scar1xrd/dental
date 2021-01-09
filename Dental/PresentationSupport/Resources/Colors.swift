//
//  Colors.swift
//  Dental
//
//  Created by Igor Sorokin on 06.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

// swiftlint:disable line_length
extension UIColor {
    /// 0x0f0f0f
    static let common: UIColor = UIColor.init(hex: 0x0f0f0f)
    
    /// 0xffffff
    static let app: UIColor = UIColor.init(hex: 0xffffff)
    
    /// 0x000000
    static let secondaryApp: UIColor = UIColor.init(hex: 0x000000)
    
    /// 0xe8e8e8
    static let selected: UIColor = UIColor.init(hex: 0xe8e8e8)
    
    /// 0x7f7f7f
    static let secondaryCommon: UIColor = UIColor.init(hex: 0x7f7f7f)
    
    /// dental color
    static let dental: UIColor = UIColor.init(red: 240/255, green: 146/255, blue: 50/255, alpha: 1.0)
    
    /// secondary dental
    static let secondaryDental: UIColor = UIColor.init(red: 111/255, green: 88/255, blue: 108/255, alpha: 1.0)
    
    /// dental selected color
    static let dentalSelected: UIColor = UIColor.init(red: 220/255, green: 126/255, blue: 30/255, alpha: 1.0)
    
    /// systemGray
    static let separator: UIColor = UIColor.init(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
    
    // smoke F8F8F8
    static let smoke: UIColor = UIColor.init(hex: 0xF8F8F8)
}
