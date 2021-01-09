//
//  MTextField.swift
//  MTextField
//
//  Created by Igor Sorokin on 20.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import InputMask

//swiftlint:disable file_length
class MTextField: UIView {
    private let disposeBag: DisposeBag = .init()
    
    private weak var placeholderLabel: UILabel!
    private weak var textField: StyledTextField!
    private weak var errorLabel: UILabel!
    
    // MARK: Reactive
    
    var text: BehaviorRelay<String?> = .init(value: nil)
    var editingDidBegin: PublishRelay<Void> = .init()
    var editingDidEnd: PublishRelay<Void> = .init()
    var isValid: BehaviorRelay<State?>? {
        didSet {
            self.setupValidState()
        }
    }
    
    enum State: Equatable {
        case valid
        case invalid(error: String?)
        
        var error: String? {
            switch self {
            case .valid:
                return nil
            case .invalid(let error):
                return error
            }
        }
        
        var isValid: Bool {
            switch self {
            case .valid:
                return true
            case .invalid:
                return false
            }
        }
    }
    
    // MARK: Input View
    
    override var inputView: UIView? {
        set {
            self.textField.inputView = newValue
        }
        get {
            return self.textField.inputView
        }
    }
    
    // MARK: Mask
    
    private lazy var listener: MaskedTextInputListener = .init()
    
    var maskFormat: String? {
        didSet {
            guard let mask = self.maskFormat else { return }
            self.textField.delegate = self.listener
            self.listener.primaryMaskFormat = mask
        }
    }
    
    // MARK: TextField
    
    var currentText: String? {
        set {
            self.textField.text = newValue
        }
        get {
            return self.textField.text
        }
    }
    
    var tfTintColor: UIColor = .systemBlue {
        didSet {
            self.textField.tintColor = tfTintColor
        }
    }
    
    var textColor: UIColor = .black {
        didSet {
            self.textField.textColor = textColor
        }
    }
    
    var textFont: UIFont = .systemFont(ofSize: 14) {
        didSet {
            self.textField.font = textFont
        }
    }
    
    var isSecureTextEntry: Bool = false {
        didSet {
            self.textField.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    var rightView: UIView? {
        didSet {
            self.textField.rightView = rightView
        }
    }
    
    var leftView: UIView? {
        didSet {
            self.textField.rightView = leftView
        }
    }
    
    // MARK: Background
    
    var roundCorners: UIRectCorner = [] {
        didSet {
            self.textField.roundCorners = roundCorners
        }
    }
    
    var cornerRadii: CGSize = .init(width: 0.0, height: 0.0) {
        didSet {
            self.textField.cornerRadii = cornerRadii
        }
    }
    
    var bgColor: UIColor = .lightGray {
        didSet {
            self.textField.bgColor = bgColor
        }
    }
    
    var borderColor: UIColor = .black {
        didSet {
            self.textField.borderColor = borderColor
        }
    }
    
    var borderWidth: CGFloat = 2.0 {
        didSet {
            self.textField.borderWidth = borderWidth
        }
    }
    
    // MARK: Bottom Line
    
    var bottomLineActiveColor: UIColor = .systemBlue
    
    var bottomLineColor: UIColor = .lightGray {
        didSet {
            self.textField.bottomLineColor = bottomLineColor
        }
    }
    
    var bottomLineWidth: CGFloat = 2.0 {
        didSet {
            self.textField.bottomLineWidth = bottomLineWidth
        }
    }
    
    // MARK: TextField Insets
    
    var textInsets: UIEdgeInsets? {
        didSet {
            self.textField.textInsets = textInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    var editingTextInsets: UIEdgeInsets? {
        didSet {
            self.textField.editingTextInsets = editingTextInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    private var textFieldAttributedPlaceholder: NSAttributedString {
        NSAttributedString(
            string: self.placeholder,
            attributes: [.foregroundColor: self.placeholderColor, .font: self.placeholderFont]
        )
    }
    
    // MARK: Properties
    
        // MARK: Placeholder
    var animateOnFocus: Bool = false {
        didSet {
            self.textField.removeTarget(nil, action: nil, for: .editingChanged)
            self.setupAnimationForPlaceholder()
        }
    }
    
    // Font
    var placeholder: String = "" {
        didSet {
            self.textField.attributedPlaceholder = self.textFieldAttributedPlaceholder
            self.placeholderLabel.text = self.placeholder
        }
    }
    
    var placeholderFont: UIFont = .systemFont(ofSize: 16) {
        didSet {
            self.textField.attributedPlaceholder = self.textFieldAttributedPlaceholder
        }
    }
    
    var placeholderActiveFont: UIFont = .systemFont(ofSize: 12) {
        didSet {
            self.placeholderLabel.font = self.placeholderActiveFont
        }
    }
    
    // Color
    var placeholderColor: UIColor = .lightGray {
        didSet {
            self.textField.attributedPlaceholder = self.textFieldAttributedPlaceholder
        }
    }
    
    var placeholderActiveColor: UIColor = .systemBlue {
        didSet {
            self.placeholderLabel.textColor = self.placeholderActiveColor
        }
    }
    
        // MARK: Error
    var errorFont: UIFont = .systemFont(ofSize: 12) {
        didSet {
            self.errorLabel.font = errorFont
        }
    }
    
    var errorColor: UIColor = .systemRed {
        didSet {
            self.errorLabel.textColor = errorColor
        }
    }
    
    // MARK: Constraints
    var placeholderActiveConstraints: ((ConstraintMaker, UITextField) -> Void) = {
        $0.bottom.equalTo($1.snp.top).offset(-4)
        $0.leading.equalTo($1)
    }
    
    var placeholderConstraints: ((ConstraintMaker, UITextField) -> Void) = {
        $0.centerY.equalTo($1)
        $0.leading.equalTo($1)
    }
    {
        didSet {
            self.placeholderLabel.snp.remakeConstraints { [unowned self] in
                self.placeholderConstraints($0, self.textField)
            }
        }
    }
    
    var errorLabelConstraints: ((ConstraintMaker, UITextField) -> Void) = {
        $0.centerY.equalTo($1)
        $0.leading.equalTo($1)
        $0.width.equalToSuperview().multipliedBy(1.0 / 2.0)
    }
    {
        didSet {
            self.errorLabel.snp.remakeConstraints { [unowned self] in
                self.errorLabelConstraints($0, self.textField)
            }
        }
    }
    
    var errorLabelActiveConstraints: ((ConstraintMaker, UITextField) -> Void) = {
        $0.top.equalTo($1.snp.bottom).offset(4)
        $0.leading.equalTo($1)
        $0.width.equalToSuperview().multipliedBy(1.0 / 2.0)
    }
    
    // Dont override
    // This uses for MTextFieldBox to affect on UIStackView
    var onAnimatePlaceholder: ((Bool) -> Void)?
    var needsShowError: ((Bool) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.setupConstraints()
        self.setupBindings()
        self.setupAnimationForPlaceholder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
        self.setupConstraints()
        self.setupBindings()
        self.setupAnimationForPlaceholder()
    }
    
    private func setupViews() {
        
        let placeholderLabel: UILabel = {
            let view = UILabel()
            view.text = self.placeholder
            view.textColor = self.placeholderActiveColor
            view.font = self.placeholderActiveFont
            view.alpha = 0
            return view
        }()
        self.placeholderLabel = placeholderLabel
        
        let textField: StyledTextField = {
            let view = StyledTextField()
            view.font = self.textFont
            view.textColor = self.textColor
            view.attributedPlaceholder = self.textFieldAttributedPlaceholder
            return view
        }()
        self.textField = textField
        self.addSubview(self.textField)
        
        let errorLabel: UILabel = {
            let view = UILabel()
            view.numberOfLines = 0
            view.alpha = 0
            view.font = self.errorFont
            view.textColor = self.errorColor
            return view
        }()
        self.errorLabel = errorLabel
    
        self.addSubview(self.textField)
        self.addSubview(self.placeholderLabel)
        self.insertSubview(self.errorLabel, at: 0)
    }
    
    private func setupConstraints() {
        
        self.placeholderLabel.snp.makeConstraints { [unowned self] in
            self.placeholderConstraints($0, self.textField)
        }
        
        self.textField.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.errorLabel.snp.makeConstraints { [unowned self] in
            self.errorLabelConstraints($0, self.textField)
        }
        
    }
    
    private func setupBindings() {
        self.textField.rx.text.bind(to: self.text).disposed(by: self.disposeBag)
        self.textField.rx.controlEvent(.editingDidBegin).bind(to: self.editingDidBegin).disposed(by: self.disposeBag)
        self.textField.rx.controlEvent(.editingDidEnd).bind(to: self.editingDidEnd).disposed(by: self.disposeBag)
    }
    
    private func setupAnimationForPlaceholder() {
        if self.animateOnFocus {
            self.textField.addTarget(self, action: #selector(self.animateToActiveState), for: .editingDidBegin)
            self.textField.addTarget(self, action: #selector(self.editingDidEnd(_:)), for: .editingDidEnd)
        } else {
            self.textField.addTarget(self, action: #selector(self.textEntered), for: .editingChanged)
        }
    }
    
    @objc private func editingDidEnd(_ textField: UITextField) {
        if textField.text?.isEmpty ?? false {
            self.animateToDefaultState()
        }
    }
    
    @objc private func textEntered(_ textField: UITextField) {
        if textField.text?.isEmpty ?? false {
            self.animateToDefaultState()
        } else {
            self.animateToActiveState()
        }
    }
    
    @objc private func animateToDefaultState() {
        
        if self.animateOnFocus {
            self.textField.attributedPlaceholder = self.textFieldAttributedPlaceholder
        }
        
        self.onAnimatePlaceholder?(false)
        
        self.placeholderLabel.snp.remakeConstraints { [unowned self] in
            self.placeholderConstraints($0, self.textField)
        }
        
        UIView.animate(withDuration: 0.2,
                       delay: 0.0,
                       options: .curveEaseIn,
                       animations: { [unowned self] in
                        self.layoutIfNeeded()
                        self.placeholderLabel.alpha = 0
                        
                        self.textField.bottomLineColor = self.bottomLineColor
        })
        
    }
    
    @objc private func animateToActiveState() {
        
        if self.animateOnFocus {
            self.textField.attributedPlaceholder = nil
        }
        
        self.onAnimatePlaceholder?(true)
        
        self.placeholderLabel.snp.remakeConstraints { [unowned self] in
            self.placeholderActiveConstraints($0, self.textField)
        }
        
        UIView.animate(withDuration: 0.2,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: { [unowned self] in
                        self.layoutIfNeeded()
                        self.placeholderLabel.alpha = 1
                        
                        self.textField.bottomLineColor = self.bottomLineActiveColor
        })
        
    }
    
    func setupValidState() {
        self.editingDidEnd
            .subscribe(onNext: { [unowned self] (_) in
                guard let state = self.isValid?.value else { return }
                self.needsShowError?(!state.isValid)
                
                if !state.isValid {
                    self.showError(state.error)
                }
            })
            .disposed(by: self.disposeBag)
        
        self.editingDidBegin
            .subscribe(onNext: { [unowned self] (_) in
                self.needsShowError?(false)
                self.hideError()
            })
            .disposed(by: self.disposeBag)
    }
    
    func showError(_ error: String?) {
        self.errorLabel.text = error
        
        self.errorLabel.snp.remakeConstraints { [unowned self] in
            self.errorLabelActiveConstraints($0, self.textField)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: { [unowned self] in
            self.errorLabel.alpha = 1
            self.layoutIfNeeded()
        })
        
    }
    
    func hideError() {
        self.errorLabel.snp.remakeConstraints { [unowned self] in
            self.errorLabelConstraints($0, self.textField)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: { [unowned self] in
            self.errorLabel.alpha = 0
            self.layoutIfNeeded()
        })
        
    }

}
