//
//  UIView+extension.swift
//  Dental
//
//  Created by Igor Sorokin on 06.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

extension UIView {
    
    func cornerRadius(
        _ value: CGFloat,
        forMask mask: CACornerMask = [
            .layerMaxXMaxYCorner,
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMinXMinYCorner
        ]
    ) {
        self.layer.maskedCorners = mask
        self.layer.cornerRadius = value
        self.clipsToBounds = true
        self.setNeedsDisplay()
    }
    
    func makeShadow(
        radius: CGFloat = 8,
        offset: CGSize = .zero,
        color: UIColor = UIColor.black,
        opacity: Float = 0.2,
        path: CGPath? = nil
    ) {
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowPath = path
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.setNeedsDisplay()
    }
    
    static func showViewAnimated(_ view: UIView, duration: TimeInterval = 0.3) {
        view.isHidden = false
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 1
        })
    }
    
    static func hideViewAnimated(_ view: UIView, duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 0
        }, completion: { (_) in
            view.isHidden = true
        })
    }

}
