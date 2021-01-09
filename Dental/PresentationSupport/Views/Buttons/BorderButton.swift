//
//  BorderButton.swift
//  Dental
//
//  Created by Igor Sorokin on 07.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class BorderButton: UIButton {

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                layer.shadowOpacity = 0.7
                setNeedsDisplay()
            } else {
                layer.shadowOpacity = 0.5
                setNeedsDisplay()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .app
        setTitleColor(.common, for: .normal)
        
        layer.borderColor = UIColor.secondaryApp.cgColor
        layer.borderWidth = 1
        
        layer.shadowColor = UIColor.secondaryApp.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 3
        layer.masksToBounds = false
        
        layer.cornerRadius = 5
    }
}
