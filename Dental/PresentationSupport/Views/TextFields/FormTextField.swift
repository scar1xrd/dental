//
//  FormTextField.swift
//  Dental
//
//  Created by Igor Sorokin on 22.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

final class FormTextField: MTextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppereance()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppereance()
        setupConstraint()
    }
    
    private func setupAppereance() {
        animateOnFocus = true
        placeholderActiveFont = Fonts.appleFont(of: 12, weight: .regular)
        placeholderFont = Fonts.appleFont(of: 16, weight: .regular)
        textFont = Fonts.appleFont(of: 16, weight: .regular)
        tfTintColor = .secondaryDental
        bottomLineActiveColor = .secondaryDental
        placeholderActiveColor = .secondaryDental
        
        placeholderActiveConstraints = {
            $0.bottom.equalTo($1.snp.top)
            $0.leading.equalTo($1)
        }
        
        errorLabelActiveConstraints = {
            $0.top.equalTo($1.snp.bottom).offset(4)
            $0.leading.equalTo($1)
            $0.width.equalToSuperview()
        }
        
    }
    
    private func setupConstraint() {
        snp.makeConstraints {
            $0.height.equalTo(44.0)
        }
    }
    
}
