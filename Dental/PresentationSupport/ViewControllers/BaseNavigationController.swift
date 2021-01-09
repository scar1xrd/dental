//
//  BaseNavigationController.swift
//  Dental
//
//  Created by Igor Sorokin on 01.03.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .dental
        view.backgroundColor = .white
        
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(nil, for: .default)
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.common
        ]
        
    }
    
}
