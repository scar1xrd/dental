//
//  NewsDetailsView.swift
//  Dental
//
//  Created by Igor Sorokin on 11.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import SnapKit

class NewsDetailsView: UIView {
    private(set) weak var collectionView: UICollectionView!
    
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
        backgroundColor = .app
        
        let layout: StretchyHeaderLayout = {
            let layout = StretchyHeaderLayout()
            return layout
        }()
        
        let collectionView: UICollectionView = {
            let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
            view.backgroundColor = .app
            return view
        }()
        
        self.collectionView = collectionView
        
        addSubview(self.collectionView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
