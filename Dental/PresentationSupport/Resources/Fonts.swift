//
//  FontsStyle.swift
//  Dental
//
//  Created by Igor Sorokin on 06.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

enum Fonts {
    static func appleFont(of size: CGFloat = 14, weight: UIFont.Weight = .regular) -> UIFont {
        return .systemFont(ofSize: size, weight: weight)
    }
}
