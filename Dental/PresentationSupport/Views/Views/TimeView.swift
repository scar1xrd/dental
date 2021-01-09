//
//  TimeView.swift
//  Dental
//
//  Created by Igor Sorokin on 16.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    private(set) weak var timeLabel: SLabel!
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.dentalSelected : UIColor.dental
        }
    }
    
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
        backgroundColor = .dental
        cornerRadius(12)
        
        let timeLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.activeDescription
            return view
        }()
        
        self.timeLabel = timeLabel
        
        addSubview(self.timeLabel)
    }
    
    private func setupConstraints() {
        timeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}
