//
//  FillButton.swift
//  Dental
//
//  Created by Igor Sorokin on 16.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class FillButton: UIButton {
    
    private weak var shadowLayer: CAShapeLayer!
    private weak var gradientLayer: CAGradientLayer!
    
    override var isHighlighted: Bool {
        didSet {
            self.alpha = isHighlighted ? 0.85 : 1.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupLayers()
    }
    
    // MARK: Setup
    private func setup() {
        self.setTitleColor(.app, for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 22)
    }
    
    // MARK: Helpers
    private func setupLayers() {
        guard self.shadowLayer == nil,
              self.gradientLayer == nil
            else {
                return
        }
        
        let shadowLayer = self.makeShadowLayer()
        let gradintLayer = self.makeGradientLayer()
        
        self.shadowLayer = shadowLayer
        self.gradientLayer = gradintLayer
        
        self.layer.insertSublayer(self.shadowLayer, at: 0)
        self.layer.insertSublayer(self.gradientLayer, above: self.shadowLayer)
    }
    
    private func makeShadowLayer() -> CAShapeLayer {
        let shadowLayer = CAShapeLayer()
        shadowLayer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 25).cgPath
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 2.0
        
        return shadowLayer
    }
    
    private func makeGradientLayer() -> CAGradientLayer {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 25).cgPath
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 238/255, green: 144/255, blue: 50/255, alpha: 1.0).cgColor,
                                UIColor(red: 243/255, green: 167/255, blue: 53/255, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        gradientLayer.mask = maskLayer
        
        return gradientLayer
    }
}
