//
//  FloatingPanelViewController+extension.swift
//  Dental
//
//  Created by Igor Sorokin on 16.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import FloatingPanel

extension FloatingPanelController: View {}

extension FloatingPanelController: ConfigurableProvider {
    
    var configurable: Configurable? { (self.contentViewController as? ConfigurableProvider)?.configurable }
    
}
