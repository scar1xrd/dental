//
//  TitleDescView.swift
//  Dental
//
//  Created by Igor Sorokin on 16.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class TitleDescView: CellSeparatorView {
    private weak var vStackView: UIStackView!
    private(set) weak var titleLabel: SLabel!
    private(set) weak var descriptionLabel: SLabel!

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
        let vStackView: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            view.spacing = 16
            return view
        }()
        
        let titleLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.defaultTitle
            return view
        }()
        
        let descriptionLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.mediumDescription
            return view
        }()
        
        self.vStackView = vStackView
        self.titleLabel = titleLabel
        self.descriptionLabel = descriptionLabel
        
        addSubview(self.vStackView)
        
        self.vStackView.addArrangedSubview(self.titleLabel)
        self.vStackView.addArrangedSubview(self.descriptionLabel)
    }
    
    private func setupConstraints() {
        vStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12))
        }
    }

}
