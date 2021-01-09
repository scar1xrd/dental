//
//  TimetablePanelLayout.swift
//  Dental
//
//  Created by Igor Sorokin on 16.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import FloatingPanel

class TimetablePanelLayout: FloatingPanelLayout {
    
    var supportedPositions: Set<FloatingPanelPosition> { .init(arrayLiteral: .full, .half)}
    
    var initialPosition: FloatingPanelPosition { .full }

    func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat { 0.5 }
    
    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        let safeArea = UIApplication.shared.keyWindow?.safeAreaInsets
        let screenHeight = UIScreen.main.bounds.height
        
        switch position {
            case .full: return (safeArea?.top ?? 0) + 20
            case .half: return screenHeight / 2
            case .tip:  return nil
            default:    return nil
        }
    }
}
