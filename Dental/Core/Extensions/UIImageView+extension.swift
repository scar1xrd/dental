//
//  UIImageView+extension.swift
//  Dental
//
//  Created by Igor Sorokin on 22.03.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setRoundOverlay(
        cornerRadius: CGFloat = 0.0,
        imageSize: CGSize,
        url: URL?,
        withPlaceholder: Bool = true,
        scale: CGFloat = UIScreen.main.scale
    ) {
        
        let resizingProcessor = ResizingImageProcessor(
            referenceSize: imageSize,
            mode: .aspectFill
        )
        
        let cropingProcessor = CroppingImageProcessor(
            size: imageSize
        )
        
        let roundCornersProcessor = RoundCornerImageProcessor(
            cornerRadius: cornerRadius,
            targetSize: nil
        )

        let overlayProcessor = OverlayImageProcessor(
            overlay: .black,
            fraction: 0.95
        )

        let processor = resizingProcessor |> cropingProcessor |> overlayProcessor |> roundCornersProcessor
        
        kf.setImage(
            with: url,
            placeholder: withPlaceholder ? Asset.iTunesArtwork.image : nil,
            options: [
                .scaleFactor(scale),
                .processor(processor),
                .transition(.fade(0.3))
            ], completionHandler:  { result in
                switch result {
                case .success:
                    break
                case .failure(let error):
                    print("error load image", error.localizedDescription)
                    
                }
            })
        
    }
    
}
