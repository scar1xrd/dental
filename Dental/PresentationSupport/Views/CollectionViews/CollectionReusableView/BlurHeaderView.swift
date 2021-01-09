//
//  ImageHeaderView.swift
//  Dental
//
//  Created by Igor Sorokin on 12.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import Kingfisher
import RxCocoa
import RxSwift

class BlurHeaderView: UICollectionReusableView {
    private let disposeBag: DisposeBag = .init()
    
    // MARK: UI
    private(set) weak var imageView: UIImageView!
    private(set) weak var visualEffectView: UIVisualEffectView!
    
    private(set) lazy var propertyAnimator: UIViewPropertyAnimator = .init()
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupPropertyAnimator()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
        setupPropertyAnimator()
    }
    
    deinit {
        propertyAnimator.stopAnimation(true)
        propertyAnimator.finishAnimation(at: .current)
    }
    
    // MARK: override
    override func prepareForReuse() {
        imageView.kf.cancelDownloadTask()
    }
    
    // MARK: public methods
    static func size() -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    }
    
    // MARK: private methods
    private func setupPropertyAnimator() {
        propertyAnimator.addAnimations { [unowned self] in
            self.visualEffectView.effect = UIBlurEffect(style: .regular)
        }
    }
    
    private func setupViews() {
        let imageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFill
            return view
        }()
        self.imageView = imageView
        
        let visualEffectView: UIVisualEffectView = {
            let view = UIVisualEffectView()
            return view
        }()
        self.visualEffectView = visualEffectView
        
        addSubview(self.imageView)
        addSubview(self.visualEffectView)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        visualEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
