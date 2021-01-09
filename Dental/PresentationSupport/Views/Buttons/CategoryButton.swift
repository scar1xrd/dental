//
//  CategoryButton.swift
//  Dental
//
//  Created by Igor Sorokin on 22.03.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class CategoryButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            stackView.transform = isHighlighted ? CGAffineTransform(scaleX: 0.9, y: 0.9) : .identity
        }
    }
    
    private weak var stackView: UIStackView!
    private weak var categoryImageView: UIImageView!
    private weak var categoryLabel: SLabel!

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
        categoryLabel.text = title
        categoryImageView.image = image
    }
    
    private func setupViews() {
        
        backgroundColor = .app
        
        let stackView: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            view.spacing = 8
            view.isUserInteractionEnabled = false
            view.alignment = .center
            return view
        }()
        
        let categoryImageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            return view
        }()
        
        let categoryLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.mediumDescription
            return view
        }()
        
        self.stackView = stackView
        self.categoryImageView = categoryImageView
        self.categoryLabel = categoryLabel
        
        self.addSubview(self.stackView)
        
        self.stackView.addArrangedSubview(self.categoryImageView)
        self.stackView.addArrangedSubview(self.categoryLabel)
    }
    
    private func setupConstraints() {
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        categoryImageView.snp.makeConstraints {
            $0.width.equalTo(snp.width).multipliedBy(1.0 / 3.0)
            $0.height.equalTo(categoryImageView.snp.width)
        }
        
    }
    
}
