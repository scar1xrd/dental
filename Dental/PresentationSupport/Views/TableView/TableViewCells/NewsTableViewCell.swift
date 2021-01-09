//
//  NewsTableViewCell.swift
//  Dental
//
//  Created by Igor Sorokin on 06.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {
    
    private weak var cardView: UIView!
    private weak var vStackView: UIStackView!
    private(set) weak var articleImageView: UIImageView!
    private(set) weak var titleLabel: SLabel!
    private(set) weak var contentLabel: SLabel!
    
    // MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }
    
    // MARK: overrides
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.makeShadow(
            radius: 7,
            offset: CGSize(width: 0, height: 6),
            opacity: 0.1
        )
    }
    
    override func prepareForReuse() {
        articleImageView.kf.cancelDownloadTask()
        titleLabel.text = nil
        contentLabel.text = nil
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            cardView.backgroundColor = .selected
            contentView.layer.shadowOpacity = 0.5
        } else {
            cardView.backgroundColor = .app
            contentView.layer.shadowOpacity = 0.2
        }
        contentView.setNeedsDisplay()
    }
    
    // MARK: public methods
    static func imageSize() -> CGSize {
        let side = UIScreen.main.bounds.width - 32
        return CGSize(width: side, height: side)
    }
    
    // MARK: private methods
    private func setupViews() {
        selectionStyle = .none
        
        let cardView: UIView = {
            let view = UIView()
            view.backgroundColor = .app
            view.cornerRadius(16)
            return view
        }()
        
        let vStackView: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            view.distribution = .fill
            view.spacing = 8
            return view
        }()
        
        let imageView: UIImageView = {
            let view = UIImageView()
            view.cornerRadius(16, forMask: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
            view.contentMode = .scaleAspectFill
            return view
        }()
        
        let titleLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.mediumTitle
            return view
        }()
        
        let contentLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.smallDescription
            return view
        }()
        
        self.cardView = cardView
        self.vStackView = vStackView
        self.articleImageView = imageView
        self.titleLabel = titleLabel
        self.contentLabel = contentLabel
        
        contentView.addSubview(self.cardView)
        self.cardView.addSubview(self.articleImageView)
        self.cardView.addSubview(self.vStackView)
        
        self.vStackView.addArrangedSubview(self.titleLabel)
        self.vStackView.addArrangedSubview(self.contentLabel)
        
    }
    
    private func setupConstraints() {
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }
        
        articleImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(articleImageView.snp.width)
        }
        
        vStackView.snp.makeConstraints {
            $0.top.equalTo(articleImageView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        
    }
    
}
