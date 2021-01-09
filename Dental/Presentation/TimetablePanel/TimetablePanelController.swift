//
//  TimetablePanelController.swift
//  Dental
//
//  Created by Igor Sorokin on 16.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import FloatingPanel

class TimetablePanelController: FloatingPanelController, FloatingPanelControllerDelegate {
    
    private let panelLayout: TimetablePanelLayout = .init()
    
    override init(delegate: FloatingPanelControllerDelegate? = nil) {
        super.init(delegate: delegate)
        
        diTag = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        delegate = self
        isRemovalInteractionEnabled = true
        surfaceView.cornerRadius = 12
        surfaceView.backgroundColor = .clear
    }
    
    //swiftlint:disable identifier_name
    func floatingPanel(
        _ vc: FloatingPanelController,
        layoutFor newCollection: UITraitCollection
    ) -> FloatingPanelLayout? {
        panelLayout
    }
    
}
