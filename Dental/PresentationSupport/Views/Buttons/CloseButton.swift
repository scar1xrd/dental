//
//  CloseButton.swift
//  Dental
//
//  Created by Igor Sorokin on 22.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class CloseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        setImage(Asset.Common.close.image.withRenderingMode(.alwaysOriginal), for: .normal)
    }

}
