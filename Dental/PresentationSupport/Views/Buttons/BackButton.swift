//
//  BackButton.swift
//  Dental
//
//  Created by Igor Sorokin on 16.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class BackButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .app
        setImage(
            Asset.Reception.strRight.image
                .withHorizontallyFlippedOrientation()
                .withRenderingMode(.alwaysOriginal),
            for: .normal
        )
    }

}
