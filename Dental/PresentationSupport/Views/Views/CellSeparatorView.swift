//
//  CellSeparatorView.swift
//  Dental
//
//  Created by Igor Sorokin on 16.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class CellSeparatorView: UIView {

    override func draw(_ rect: CGRect) {
        let separator = UIBezierPath()
        separator.lineWidth = 1
        let startPoint = CGPoint(x: rect.minX + 30, y: rect.maxY)
        let endPoint = CGPoint(x: rect.maxX, y: rect.maxY)
        separator.move(to: startPoint)
        separator.addLine(to: endPoint)
        
        UIColor.separator.setFill()
        separator.fill()
    }
    
}
