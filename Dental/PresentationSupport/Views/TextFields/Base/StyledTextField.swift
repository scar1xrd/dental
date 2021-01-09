//
//  StyledTextField.swift
//  MTextField
//
//  Created by Igor Sorokin on 20.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class StyledTextField: UITextField {
    
    // MARK: Background
    
    var roundCorners: UIRectCorner = [] {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var cornerRadii: CGSize = .init(width: 0.0, height: 0.0) {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var bgColor: UIColor? = .white {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var borderColor: UIColor? = .clear {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var borderWidth: CGFloat = 0.0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    private var halfBorderWidth: CGFloat {
        return self.borderWidth / 2.0
    }
    
    // MARK: Bottom Line
    
    var bottomLineColor: UIColor? = .lightGray {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var bottomLineWidth: CGFloat = 2.0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    // MARK: TextField Insets
    
    var textInsets: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
    var editingTextInsets: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    override func draw(_ rect: CGRect) {
        let availableRect = CGRect(x: rect.origin.x + self.halfBorderWidth,
                                   y: rect.origin.y + self.halfBorderWidth,
                                   width: rect.width - self.borderWidth,
                                   height: rect.height - self.borderWidth)
        
        let roundPath = UIBezierPath(
            roundedRect: availableRect,
            byRoundingCorners: self.roundCorners,
            cornerRadii: self.cornerRadii
        )
        roundPath.lineWidth = self.borderWidth
        
        self.bgColor?.setFill()
        self.borderColor?.setStroke()
        
        roundPath.fill()
        roundPath.stroke()
        
        let bottomLinePath = UIBezierPath()
        bottomLinePath.lineWidth = self.bottomLineWidth
        bottomLinePath.lineCapStyle = .round
        
        bottomLinePath.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        bottomLinePath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        self.bottomLineColor?.setStroke()
        bottomLinePath.stroke()
    }
    
    private func setup() {
        self.borderStyle = .none
        self.backgroundColor = .clear
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.textInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.editingTextInsets)
    }
    
}
