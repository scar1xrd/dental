//
//  DentistTimetableView.swift
//  Dental
//
//  Created by scar1xrd on 16/02/2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class DentistTimetableView: UIView {
    private(set) weak var collectionView: UICollectionView!
    private(set) weak var blurEffectView: UIVisualEffectView!
    
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
        backgroundColor = UIColor.app.withAlphaComponent(0.7)
        
        let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
            view.backgroundColor = .clear
            return view
        }()
        
        let blurEffectView: UIVisualEffectView = {
            let view = UIVisualEffectView()
            view.effect = UIBlurEffect(style: .light)
            return view
        }()
        
        self.collectionView = collectionView
        self.blurEffectView = blurEffectView
        
        addSubview(self.collectionView)
        insertSubview(blurEffectView, at: 0)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 22, left: 12, bottom: 22, right: 12))
        }
        
        blurEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
