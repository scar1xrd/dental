//
//  ProfileRow.swift
//  Dental
//
//  Created by Igor Sorokin on 24.04.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

final class ProfileRow: UIControl {
    
    weak var topSeparator: UIView!
    weak var hStackView: UIStackView!
    weak var imageView: UIImageView!
    weak var label: SLabel!
    weak var accessoryImageView: UIImageView!
    weak var bottomSeparator: UIView!
    
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
        
        let topSeparator: UIView = {
            let view = UIView()
            view.backgroundColor = .separator
            return view
        }()
        
        let hStackView: UIStackView = {
            let view = UIStackView()
            view.axis = .horizontal
            view.spacing = 8
            view.distribution = .fill
            view.alignment = .fill
            return view
        }()
        
        let imageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            return view
        }()
        
        let label: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.activeDescription
            return view
        }()
        
        let accessoryImageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            return view
        }()
        
        let bottomSeparator: UIView = {
            let view = UIView()
            view.backgroundColor = .separator
            return view
        }()
        
        self.topSeparator = topSeparator
        self.hStackView = hStackView
        self.imageView = imageView
        self.label = label
        self.accessoryImageView = accessoryImageView
        self.bottomSeparator = bottomSeparator
        
        addSubview(self.topSeparator)
        addSubview(self.hStackView)
        addSubview(self.bottomSeparator)
        
        self.hStackView.addArrangedSubview(imageView)
        self.hStackView.addArrangedSubview(label)
        self.hStackView.addArrangedSubview(accessoryImageView)
    }
    
    private func setupConstraints() {
        
        topSeparator.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.leading.trailing.equalTo(0)
            $0.height.equalTo(1)
        }
        
        imageView.snp.makeConstraints {
            $0.height.width.equalTo(30)
        }
        
        hStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
                .inset(UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        }
        
        bottomSeparator.snp.makeConstraints {
            $0.leading.trailing.equalTo(0)
            $0.bottom.equalTo(0)
            $0.height.equalTo(1)
        }
        
    }
    
}
