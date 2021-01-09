//
//  FormView.swift
//  Dental
//
//  Created by Igor Sorokin on 22.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class FormView: UIView {
    private(set) weak var vScrollView: UIScrollView!
    private(set) weak var contentView: UIView!
    private(set) weak var vStackView: UIStackView!
    private(set) weak var nameTextFieldBox: MTextFieldBox<FormTextField>!
    private(set) weak var borndayTextFieldBox: MTextFieldBox<FormTextField>!
    private(set) weak var phoneTextFieldBox: MTextFieldBox<FormTextField>!
    private(set) weak var phoneDescriptionLabel: SLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
        self.setupConstraints()
    }
    
    //swiftlint:disable function_body_length
    private func setupViews() {
        backgroundColor = .white
        
        let vScrollView: UIScrollView = {
            let view = UIScrollView()
            view.alwaysBounceVertical = true
            view.showsVerticalScrollIndicator = false
            return view
        }()
        
        let contentView: UIView = {
            let view = UIView()
            return view
        }()
        
        let vStackView: UIStackView = {
            let view = UIStackView()
            view.spacing = 14
            view.axis = .vertical
            return view
        }()
        
        let nameTextFieldBox: MTextFieldBox<FormTextField> = {
            let view = MTextFieldBox<FormTextField>()
            view.textField.placeholder = L10n.Form.name
            return view
        }()
        
        let borndayTextFieldBox: MTextFieldBox<FormTextField> = {
            let view = MTextFieldBox<FormTextField>()
            view.textField.placeholder = L10n.Form.bornDate
            return view
        }()
        
        let phoneTextFieldBox: MTextFieldBox<FormTextField> = {
            let view = MTextFieldBox<FormTextField>()
            view.textField.placeholder = L10n.Form.phone
            view.textField.maskFormat = TFMask.phone.rawValue
            return view
        }()
        
        let phoneDescriptionLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.description
            view.text = L10n.Form.phoneDesc
            return view
        }()
        
        self.vScrollView = vScrollView
        self.contentView = contentView
        self.vStackView = vStackView
        self.nameTextFieldBox = nameTextFieldBox
        self.borndayTextFieldBox = borndayTextFieldBox
        self.phoneTextFieldBox = phoneTextFieldBox
        self.phoneDescriptionLabel = phoneDescriptionLabel
        
        self.addSubview(self.vScrollView)
        self.vScrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.vStackView)
        
        self.vStackView.addArrangedSubview(self.nameTextFieldBox)
        self.vStackView.addArrangedSubview(self.borndayTextFieldBox)
        self.vStackView.addArrangedSubview(self.phoneTextFieldBox)
        self.vStackView.setCustomSpacing(8, after: self.phoneTextFieldBox)
        self.vStackView.addArrangedSubview(self.phoneDescriptionLabel)
    }
    
    private func setupConstraints() {
        self.vScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints { [unowned self] in
            $0.edges.equalToSuperview()
            $0.width.equalTo(self.vScrollView.snp.width)
        }
        
        self.vStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 12, left: 14, bottom: 12, right: 14))
        }
    }
    
}
