//
//  StretchyHeaderLayout.swift
//  Dental
//
//  Created by Igor Sorokin on 12.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {
    private var shouldInvalidateSizes: Bool = true
    
    var estimatedCellSize: CGSize {
        guard let collectionView = collectionView else { return .zero }
        let leftRightSectionInsets = sectionInset.left + sectionInset.right
        let leftRightContentInsets = collectionView.contentInset.left + collectionView.contentInset.right
        
        return CGSize(
            width: collectionView.frame.width - leftRightContentInsets - leftRightSectionInsets,
            height: 0
        )
    }
    
    var headerSize: CGSize {
        guard let collectionView = self.collectionView else { return .zero }
        return .init(width: collectionView.frame.width, height: collectionView.frame.width)
    }
    
    override func prepare() {
        super.prepare()
        guard self.shouldInvalidateSizes else { return }
        self.shouldInvalidateSizes = false
        
        self.estimatedItemSize = self.estimatedCellSize
        self.headerReferenceSize = self.headerSize
    }
    
    override func shouldInvalidateLayout(
        forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes,
        withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes
    ) -> Bool {
        if preferredAttributes.frame.size != self.estimatedCellSize {
            self.itemSize = preferredAttributes.frame.size
            self.estimatedItemSize = .zero
            return false
        }
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
         let layoutAttributes = super.layoutAttributesForElements(in: rect)

        layoutAttributes?.forEach {
            
            guard $0.representedElementKind == UICollectionView.elementKindSectionHeader,
                  let collectionView = self.collectionView,
                  $0.indexPath.section == 0 else { return }

            let contentOffsetY = collectionView.contentOffset.y
            let adjustedContentInsetTop = collectionView.adjustedContentInset.top
            let realContentOffset = contentOffsetY + adjustedContentInsetTop

            guard realContentOffset < 0 else { return }

            let width = $0.frame.width
            let height = $0.frame.height - realContentOffset

            $0.frame = CGRect(x: 0, y: realContentOffset, width: width, height: height)
        }

        return layoutAttributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
