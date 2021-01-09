//
//  NewsDetailsContentView.swift
//  Dental
//
//  Created by Igor Sorokin on 12.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import SnapKit

class NewsDetailsContentView: UIView, CellView {
    private weak var stackView: UIStackView!
    private(set) weak var titleLabel: SLabel!
    private(set) weak var contentTextView: ContentTextView!
    
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
    
    func size(for prefferedSize: CGSize) -> CGSize {
        if frame == .zero {
            layoutIfNeeded()
        }
        
        var prefferedSize = prefferedSize
        let size = CGSize(width: prefferedSize.width, height: UIView.noIntrinsicMetric)
        let height = systemLayoutSizeFitting(size).height
        
        prefferedSize.height = height
        
        return prefferedSize
    }
    
    private func setupViews() {
        backgroundColor = .app

        let stackView: UIStackView = {
            let view = UIStackView()
            view.distribution = .fill
            view.alignment = .fill
            view.axis = .vertical
            return view
        }()
        
        let titleLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.largeTitle
            return view
        }()
        
        let contentTextView: ContentTextView = {
            let view = ContentTextView()
            return view
        }()
        
        self.stackView = stackView
        self.titleLabel = titleLabel
        self.contentTextView = contentTextView
        
        addSubview(self.stackView)
        
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.contentTextView)
    }
    
    private func setupConstraints() {
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
                .inset(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
    }
}
