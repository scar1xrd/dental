//
//  GenericCollectionViewCell.swift
//  Dental
//
//  Created by Igor Sorokin on 12.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class GenericCollectionViewCell<View: UIView & CellView>: UICollectionViewCell {
    private(set) weak var view: View!
    
    override var isSelected: Bool {
        didSet {
            view.setSelected(isSelected, animated: true)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            view.setHighlighted(isHighlighted, animated: true)
        }
    }
    
    func setup(view: View) {
        self.view = view
        contentView.addSubview(view)
        
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        view.prepareForReuse()
    }
    
    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        
        layoutAttributes.frame.size = view.size(for: layoutAttributes.frame.size)
        
        return layoutAttributes
    }
}
