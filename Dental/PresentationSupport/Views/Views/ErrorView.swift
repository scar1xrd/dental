//
//  ErrorView.swift
//  Dental
//
//  Created by Igor Sorokin on 07.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    private weak var stackView: UIStackView!
    private(set) weak var errorLabel: SLabel!
    private(set) weak var reloadButton: BorderButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        let stackView: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            view.distribution = .fill
            view.spacing = 10
            return view
        }()
        
        let errorLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.warning
            return view
        }()
        
        let reloadButton: BorderButton = {
            let view = BorderButton()
            view.setContentCompressionResistancePriority(.required, for: .vertical)
            return view
        }()
        
        self.stackView = stackView
        self.errorLabel = errorLabel
        self.reloadButton = reloadButton
        
        self.addSubview(self.stackView)
        
        self.stackView.addArrangedSubview(self.errorLabel)
        self.stackView.addArrangedSubview(UIView())
        self.stackView.addArrangedSubview(self.reloadButton)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
