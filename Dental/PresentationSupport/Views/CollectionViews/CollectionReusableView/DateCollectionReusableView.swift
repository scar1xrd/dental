//
//  DateCollectionReusableView.swift
//  Dental
//
//  Created by Igor Sorokin on 16.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class DateCollectionReusableView: UICollectionReusableView {
    private(set) weak var dateLabel: SLabel!
    
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
        let dateLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.defaultTitle
            return view
        }()
        self.dateLabel = dateLabel
        
        self.addSubview(self.dateLabel)
    }
    
    private func setupConstraints() {
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}
