//
//  SLabel.swift
//  Dental
//
//  Created by Igor Sorokin on 06.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class SLabel: UILabel {

    var textStyle: TextStyle?

    override var text: String? {
        set {
            if let textStyle = self.textStyle {
                self.numberOfLines = textStyle.numberOfLines
                let attributedString = NSAttributedString(
                    string: newValue ?? "",
                    attributes: textStyle.textAttributes
                )
                self.attributedText = attributedString
            } else {
                self.attributedText = NSAttributedString(string: newValue ?? "")
            }
        }
        get {
            return self.attributedText?.string
        }
    }
    
}
