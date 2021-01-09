//
//  BranchContentView.swift
//  Dental
//
//  Created by Igor Sorokin on 01.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class BranchContentView: UIView, CellView {
    private weak var hStackView: UIStackView!
    private(set) weak var imageView: UIImageView!
    
    private(set) weak var textVStackView: UIStackView!
    private(set) weak var titleLabel: SLabel!
    private(set) weak var descriptionLabel: SLabel!
    
    private(set) weak var accessoryImageView: UIImageView!
    
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
    
    func prepareForReuse() {
        imageView.kf.cancelDownloadTask()
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
    
    static func imageViewSize() -> CGSize {
        CGSize(width: 80, height: 80)
    }
    
    func setHighlighted(_ highlighted: Bool, animated: Bool) {
        backgroundColor = highlighted ? .selected : .app
    }
    
    //swiftlint:disable function_body_length
    private func setupViews() {
        backgroundColor = .app

        let hStackView: UIStackView = {
            let view = UIStackView()
            view.axis = .horizontal
            view.spacing = 18
            view.alignment = .center
            return view
        }()
        
        let imageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFill
            view.cornerRadius(40)
            return view
        }()
        
        let textStackView: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            view.spacing = 4
            return view
        }()
        
        let titleLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.mediumTitle
            return view
        }()
        
        let descriptionLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.description
            return view
        }()
        
        let accessoryImageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.tintColor = .darkGray
            view.image = Asset.Reception.strRight.image.withRenderingMode(.alwaysTemplate)
            return view
        }()
        
        self.hStackView = hStackView
        self.imageView = imageView
        self.textVStackView = textStackView
        self.titleLabel = titleLabel
        self.descriptionLabel = descriptionLabel
        self.accessoryImageView = accessoryImageView
        
        addSubview(self.hStackView)
        
        self.hStackView.addArrangedSubview(self.imageView)
        self.hStackView.addArrangedSubview(self.textVStackView)
        self.hStackView.addArrangedSubview(self.accessoryImageView)
        
        self.textVStackView.addArrangedSubview(self.titleLabel)
        self.textVStackView.addArrangedSubview(self.descriptionLabel)
    }
    
    private func setupConstraints() {
        hStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
        
        imageView.snp.makeConstraints {
            $0.height.width.equalTo(80)
        }
        
        accessoryImageView.snp.makeConstraints {
            $0.width.equalTo(26)
        }
    }
}
