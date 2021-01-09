//
//  CategoriesView.swift
//  Dental
//
//  Created by Igor Sorokin on 16.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class CategoriesView: CellSeparatorView {
    typealias Category = (String?, UIImage?)
    private weak var vStackView: UIStackView!

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
    
    func setupCategoryView(_ category: String?, image: UIImage?) {
        let hStackView: UIStackView = {
            let view = UIStackView()
            view.spacing = 8
            view.axis = .horizontal
            view.alignment = .top
            return view
        }()
        
        let imageVStackView: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            return view
        }()
        
        let imageView: UIImageView = {
            let view = UIImageView()
            view.image = image
            view.contentMode = .scaleAspectFit
            return view
        }()
        
        let categoryLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.mediumDescription
            view.text = category
            return view
        }()
        
        vStackView.addArrangedSubview(hStackView)
        
        hStackView.addArrangedSubview(imageVStackView)
        hStackView.addArrangedSubview(categoryLabel)
        
        imageVStackView.addArrangedSubview(imageView)
        imageVStackView.addArrangedSubview(UIView())
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(32)
        }
    }
    
    private func setupViews() {
        let vStackView: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            view.spacing = 8
            return view
        }()
        
        self.vStackView = vStackView
        
        addSubview(self.vStackView)
    }
    
    private func setupConstraints() {
        vStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12))
        }
    }

}
