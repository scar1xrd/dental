//
//  AppointmentFormViewController.swift
//  Dental
//
//  Created by scar1xrd on 16/02/2020.
//  Copyright 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import RxSwift

class AppointmentFormViewController: BaseViewController, View {
    // MARK: Private properties
    private let disposeBag: DisposeBag = .init()
    private var viewModel: AppointmentFormViewModel!
    private let borndayInputView: UIPickerView = .init()
    private var pickerAdapter: AppointmentFormPickerViewAdapter!
    
    // MARK: UI
    private weak var nameTextFieldBox: MTextFieldBox<FormTextField>!
    private weak var borndayTextFieldBox: MTextFieldBox<FormTextField>!
    private weak var phoneTextFieldBox: MTextFieldBox<FormTextField>!
    private weak var phoneDescriptionLabel: SLabel!
    private weak var acceptButton: FillButton!
    private weak var closeButton: CloseButton!
    
    deinit {
        print("DEINIT \(self)")
    }
    
    override func loadView() {
        super.loadView()
        let view = AppointmentFormView()
        self.view = view
        nameTextFieldBox = view.formView.nameTextFieldBox
        borndayTextFieldBox = view.formView.borndayTextFieldBox
        phoneTextFieldBox = view.formView.phoneTextFieldBox
        phoneDescriptionLabel = view.formView.phoneDescriptionLabel
        acceptButton = view.acceptButton
        closeButton = view.closeButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
}

// MARK: - VIEW MODEL INJECTABLE

extension AppointmentFormViewController: ViewModelInjectable {
    func set(viewModel: ViewModel) {
        self.viewModel = viewModel as? AppointmentFormViewModel
    }
}

// MARK: - CONFIGURABLE PROVIDER

extension AppointmentFormViewController: ConfigurableProvider {
    var configurable: Configurable? { viewModel }
}

// MARK: - CONFIGURATIONS

private extension AppointmentFormViewController {
    func configure() {
        configureViews()
        setupBindings()
        configureHandlers()
    }

    func configureViews() {
        configureBorndayAdapter()
        configureNameTF()
        configureBorndayTF()
        configurePhoneTF()
    }

    func configureBorndayAdapter() {
        pickerAdapter = AppointmentFormPickerViewAdapter(pickerView: borndayInputView)
        pickerAdapter.onDidSelectRow = { [unowned self] in
            self.borndayTextFieldBox.textField.currentText = $0
        }
        
        borndayInputView.dataSource = pickerAdapter
        borndayInputView.delegate = pickerAdapter
        borndayTextFieldBox.textField.inputView = borndayInputView
    }
    
    func configureNameTF() {
        nameTextFieldBox.textField.editingDidBegin
            .subscribe(onNext: { [unowned self] (_) in
                self.nameTextFieldBox.hideError()
            })
            .disposed(by: disposeBag)

        nameTextFieldBox.textField.editingDidEnd
            .subscribe(onNext: { [unowned self] (_) in
                if !self.viewModel.nameValid.value {
                    self.nameTextFieldBox.showError(L10n.Form.nameError)
                }
            })
            .disposed(by: disposeBag)
    }

    func configureBorndayTF() {
        borndayTextFieldBox.textField.editingDidBegin
            .subscribe(onNext: { [unowned self] (_) in
                self.borndayTextFieldBox.hideError()
            })
            .disposed(by: disposeBag)

        borndayTextFieldBox.textField.editingDidEnd
            .subscribe(onNext: { [unowned self] (_) in
                if !self.viewModel.borndayValid.value {
                    self.borndayTextFieldBox.showError(L10n.Form.borndayError)
                }
            })
            .disposed(by: disposeBag)
    }

    func configurePhoneTF() {
        phoneTextFieldBox.textField.editingDidBegin
            .subscribe(onNext: { [unowned self] (_) in
                self.phoneTextFieldBox.hideError()
            })
            .disposed(by: disposeBag)

        phoneTextFieldBox.textField.editingDidEnd
            .subscribe(onNext: { [unowned self] (_) in
                if !self.viewModel.phoneValid.value {
                    self.phoneTextFieldBox.showError(L10n.Form.phoneError)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setupBindings() {
        nameTextFieldBox.textField.text.bind(to: viewModel.name).disposed(by: disposeBag)
        borndayTextFieldBox.textField.text.bind(to: viewModel.bornday).disposed(by: disposeBag)
        phoneTextFieldBox.textField.text.bind(to: viewModel.phone).disposed(by: disposeBag)

        acceptButton.rx.tap
            .subscribe(onNext: { [unowned self] (_) in
                self.viewModel.sendAppointmentAction.execute()
            })
            .disposed(by: disposeBag)
        
        closeButton.rx.tap
            .subscribe(onNext: { [unowned self] (_) in
                self.viewModel.closeForm()
            })
            .disposed(by: disposeBag)
    }
    
    func configureHandlers() {
        viewModel.sendAppointmentAction.executing
            .subscribe(onNext: { [unowned self] in
                $0 ? self.showHUD() : self.hideHUD()
            })
            .disposed(by: disposeBag)
        
        viewModel.sendAppointmentAction.errors
            .subscribe(onNext: { [unowned self] in
                
                if ErrorManager.isFormError(actionError: $0) {
                    self.showFormError(ErrorManager.toFormError(actionError: $0))
                } else {
                    let apiError = ErrorManager.toApiError(actionError: $0)
                    self.showAlert(title: apiError.localizedDescription)
                }
                
            })
            .disposed(by: disposeBag)
        
        viewModel.sendAppointmentAction
            .onElements(action: { [unowned self] (_) in
                self.showAlert(title: L10n.Form.successAppointmentReq) { [unowned self] in
                    self.viewModel.closeFormAndPopToRoot()
                }
            }).disposed(by: disposeBag)
    }
    
    func showFormError(_ error: FormError) {
        switch error {
        case .wrongName:
            nameTextFieldBox.showError(error.localizedDescription)
        case .wrongBornday:
            borndayTextFieldBox.showError(error.localizedDescription)
        case .wrongPhone:
            phoneTextFieldBox.showError(error.localizedDescription)
        default:
            showAlert(title: error.localizedDescription)
        }
    }
    
}
