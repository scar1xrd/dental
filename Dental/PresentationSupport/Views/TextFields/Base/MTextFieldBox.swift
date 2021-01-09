//
//  BouncyTextField.swift
//  MTextFieldBox
//
//  Created by Igor Sorokin on 20.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import RxSwift

class MTextFieldBox<TextField: MTextField>: UIView {
    
    // MARK: Private properties
    private weak var vStackView: UIStackView!
    private weak var fakeView: UIView!
    private weak var fakePlaceholderLabel: UILabel!
    private weak var fakeErrorLabel: UILabel!
    
    private(set) weak var textField: TextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.setupConstraints()
        self.setupHandlers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
        self.setupConstraints()
        self.setupHandlers()
    }
    
    func showError(_ error: String?) {
        self.textField.showError(error)
        
        UIView.animate(withDuration: 0.1) {
            self.fakeErrorLabel.isHidden = false
        }
    }
    
    func hideError() {
        self.textField.hideError()
        
        UIView.animate(withDuration: 0.1) {
            self.fakeErrorLabel.isHidden = true
        }
    }
    
    private func setupViews() {
        
        let vStackView: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            return view
        }()
        self.vStackView = vStackView
        
        let fakePlaceholderLabel: UILabel = {
            let view = UILabel()
            view.isHidden = true
            view.alpha = 0
            view.text = "fake placeholder"
            return view
        }()
        self.fakePlaceholderLabel = fakePlaceholderLabel
        
        let fakeView: UIView = {
            let view = UIView()
            return view
        }()
        self.fakeView = fakeView
        
        let fakeErrorLabel: UILabel = {
            let view = UILabel()
            view.isHidden = true
            view.alpha = 0
            view.numberOfLines = 0
            view.text = "fake error"
            return view
        }()
        self.fakeErrorLabel = fakeErrorLabel
        
        let textField: TextField = {
            let view = TextField()
            return view
        }()
        self.textField = textField
        
        self.addSubview(self.vStackView)
        
        self.vStackView.addArrangedSubview(self.fakePlaceholderLabel)
        self.vStackView.addArrangedSubview(self.fakeView)
        self.vStackView.addArrangedSubview(self.fakeErrorLabel)
        
        self.fakeView.addSubview(self.textField)
    }
    
    private func setupConstraints() {
        
        self.vStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.fakeView.snp.makeConstraints {
            $0.height.equalTo(44.0)
        }
        
        self.textField.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    private func setupHandlers() {
        
        self.textField.onAnimatePlaceholder = {
            if $0 {
                UIView.animate(withDuration: 0.2) {
                    self.fakePlaceholderLabel.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.fakePlaceholderLabel.isHidden = true
                }
            }
        }
        
        self.textField.needsShowError = { [unowned self] in
            
            if $0 {
                UIView.animate(withDuration: 0.1) {
                    self.fakeErrorLabel.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 0.1) {
                    self.fakeErrorLabel.isHidden = true
                }
            }
            
        }
        
    }
    
}
