//
//  GradientView.swift
//  Dental
//
//  Created by Igor Sorokin on 16.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class GradientView: UIView {
    var gradientColors: [CGColor] = [UIColor.app.cgColor, UIColor.app.withAlphaComponent(0).cgColor]
    var colorLocations: [CGFloat] = [0.0, 1.0]
    var startPoint: ((CGRect) -> CGPoint)?
    var endPoint: ((CGRect) -> CGPoint)?

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let colorspace = CGColorSpaceCreateDeviceRGB()
        
        let colorLocations = self.colorLocations
        let colors = self.gradientColors
        
        let gradient = CGGradient(
            colorsSpace: colorspace,
            colors: colors as CFArray,
            locations: colorLocations
        )!
        
        let startPoint: CGPoint
        if let startPointHandler = self.startPoint {
            startPoint = startPointHandler(rect)
        } else {
            startPoint = CGPoint(x: rect.midX, y: rect.maxY)
        }
        
        let endPoint: CGPoint
        if let endPointHandler = self.endPoint {
            endPoint = endPointHandler(rect)
        } else {
            endPoint = CGPoint(x: rect.midX, y: rect.minY)
        }
        
        context?.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
    }

}
