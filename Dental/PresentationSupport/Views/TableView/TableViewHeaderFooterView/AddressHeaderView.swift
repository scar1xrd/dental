//
//  AddressHeaderView.swift
//  Dental
//
//  Created by Igor Sorokin on 09.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class AddressHeaderView: UITableViewHeaderFooterView {
    private(set) weak var titleLabel: SLabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        contentView.backgroundColor = .app
        
        let titleLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.defaultTitle
            return view
        }()
        
        self.titleLabel = titleLabel
        contentView.addSubview(self.titleLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 12, left: 8, bottom: 8, right: 8))
        }
    }
    
}
