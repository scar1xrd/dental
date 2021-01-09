//
//  RowButton.swift
//  Dental
//
//  Created by Igor Sorokin on 07.03.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class RowButton: UIControl {
    
    override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = isHighlighted ? .separator : .app
        }
    }
    
    private weak var contentView: UIView!
    private weak var hStackView: UIStackView!
    private weak var categoryImageView: UIImageView!
    private weak var titleLabel: SLabel!
    private weak var accessoryImageView: UIImageView!

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
    
    func setTitle(_ title: String?, withImage image: UIImage?) {
        titleLabel.text = title
        categoryImageView.image = image
    }
    
    private func setupViews() {
        
        backgroundColor = .separator
        
        let contentView: UIView = {
            let view = UIView()
            view.backgroundColor = .app
            view.isUserInteractionEnabled = false
            return view
        }()
        self.contentView = contentView
        
        let hStackView: UIStackView = {
            let view = UIStackView()
            view.axis = .horizontal
            view.spacing = 16
            view.isUserInteractionEnabled = false
            return view
        }()
        self.hStackView = hStackView
        
        let categoryImageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.isUserInteractionEnabled = false
            return view
        }()
        self.categoryImageView = categoryImageView
        
        let titleLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.mediumDescription
            view.isUserInteractionEnabled = false
            return view
        }()
        self.titleLabel = titleLabel
        
        let accessoryImageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.tintColor = .secondaryApp
            view.image = Asset.Reception.strRight.image.withRenderingMode(.alwaysTemplate)
            view.isUserInteractionEnabled = false
            return view
        }()
        self.accessoryImageView = accessoryImageView
        
        addSubview(self.contentView)
        self.contentView.addSubview(self.hStackView)
        
        self.hStackView.addArrangedSubview(self.categoryImageView)
        self.hStackView.addArrangedSubview(self.titleLabel)
        self.hStackView.addArrangedSubview(self.accessoryImageView)
    }
    
    private func setupConstraints() {
        
        self.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0))
        }
        
        hStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        categoryImageView.snp.makeConstraints {
            $0.width.equalTo(24)
        }
        
        accessoryImageView.snp.makeConstraints {
            $0.width.equalTo(24)
        }
        
    }

}
