//
//  DentistsContentView.swift
//  Dental
//
//  Created by Igor Sorokin on 09.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class DentistsContentView: UIView, CellView {
    
    private weak var hStackView: UIStackView!
    private weak var vImageStackView: UIStackView!
    private(set) weak var dentistImageView: UIImageView!
    private weak var vTextStackView: UIStackView!
    private(set) weak var dentistNameLabel: SLabel!
    
    var branchesViews: [UIView] = []
    
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
    
    func setDentistBranch(_ branch: String) {
        let branchLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.secondaryDescription
            view.text = "• " + branch
            return view
        }()
        
        vTextStackView.addArrangedSubview(branchLabel)
        branchesViews.append(branchLabel)
    }
    
    func prepareForReuse() {
        dentistImageView.kf.cancelDownloadTask()
        dentistNameLabel.text = nil
        branchesViews.forEach { $0.removeFromSuperview() }
    }
    
    func setHighlighted(_ highlighted: Bool, animated: Bool) {
        backgroundColor = highlighted ? .selected : .app
    }
    
    private func setupViews() {
        backgroundColor = .app
        
        let hStackView: UIStackView = {
            let view = UIStackView()
            view.axis = .horizontal
            view.spacing = 12
            return view
        }()
        
        let vImageStackView: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            return view
        }()
        
        let dentistImageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFill
            view.cornerRadius(27)
            return view
        }()
        
        let vTextStackView: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            view.spacing = 8
            return view
        }()
        
        let dentistNameLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.defaultTitle
            return view
        }()
        
        self.hStackView = hStackView
        self.vImageStackView = vImageStackView
        self.dentistImageView = dentistImageView
        self.vTextStackView = vTextStackView
        self.dentistNameLabel = dentistNameLabel
        
        addSubview(self.hStackView)
        
        self.hStackView.addArrangedSubview(self.vImageStackView)
        self.hStackView.addArrangedSubview(self.vTextStackView)
        
        self.vImageStackView.addArrangedSubview(self.dentistImageView)
        self.vImageStackView.addArrangedSubview(UIView())
        
        self.vTextStackView.addArrangedSubview(self.dentistNameLabel)
    }
    
    private func setupConstraints() {
        hStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        }
        
        dentistImageView.snp.makeConstraints {
            $0.height.width.equalTo(54)
        }
    }
}
