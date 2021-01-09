//
//  DentistDetailsViewController.swift
//  Dental
//
//  Created by scar1xrd on 16/02/2020.
//  Copyright 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import RxSwift

class DentistDetailsViewController: BaseViewController, View {
    // MARK: Private properties
    private let disposeBag: DisposeBag = .init()
    private var viewModel: DentistDetailsViewModel!
    
    // MARK: UI
    private weak var backButton: BackButton!
    private weak var dentistImageView: UIImageView!
    private weak var nameLabel: SLabel!
    private weak var vScrollView: UIScrollView!
    private weak var aboutView: TitleDescView!
    private weak var branchesView: CategoriesView!
    private weak var experienceView: TitleDescView!
    private weak var educationView: TitleDescView!
    private weak var appointmentButton: FillButton!
    
    deinit {
        print("DEINIT \(self)")
    }
    
    override func loadView() {
        super.loadView()
        let view = DentistDetailsView()
        self.view = view
        backButton = view.backButton
        dentistImageView = view.dentistImageView
        nameLabel = view.nameLabel
        vScrollView = view.vScrollView
        aboutView = view.aboutView
        branchesView = view.branchesView
        experienceView = view.experienceView
        educationView = view.educationView
        appointmentButton = view.appointmentButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard !(navigationController?.isNavigationBarHidden ?? true) else { return }
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}

// MARK: - VIEW MODEL INJECTABLE

extension DentistDetailsViewController: ViewModelInjectable {
    func set(viewModel: ViewModel) {
        self.viewModel = viewModel as? DentistDetailsViewModel
    }
}

// MARK: - CONFIGURABLE PROVIDER

extension DentistDetailsViewController: ConfigurableProvider {
    var configurable: Configurable? { viewModel }
}

// MARK: - CONFIGURATIONS

private extension DentistDetailsViewController {
    func configure() {
        configureViews()
        configureBindings()
    }
    
    func configureViews() {
        guard let dentist = viewModel.dentist else { return }
        
        vScrollView.alwaysBounceVertical = true
        vScrollView.contentInset = UIEdgeInsets(
            top: UIScreen.main.bounds.width,
            left: 0,
            bottom: 85,
            right: 0
        )
        
        dentistImageView.setRoundOverlay(
            imageSize: CGSize(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.width
            ),
            url: URL(string: dentist.srcImage)
        )
        
        nameLabel.text = dentist.name
        
        aboutView.titleLabel.text = L10n.Dentist.aboutTitle
        aboutView.descriptionLabel.text = dentist.description
        
        let branches = dentist.branch.reduce("") { $0 + "• " + $1 + "\n" }
        branchesView.setupCategoryView(branches, image: Asset.Reception.tagged.image)
        
        experienceView.titleLabel.text = L10n.Dentist.experienceTitle
        experienceView.descriptionLabel.text = L10n.Dentist.totalExprerience + dentist.experience
        
        educationView.titleLabel.text = L10n.Dentist.aboutTitle
        educationView.descriptionLabel.text = dentist.education
    }
    
    func configureBindings() {
        backButton.rx.tap
            .subscribe(onNext: { [unowned self] (_) in
                self.viewModel.closeController()
            })
            .disposed(by: disposeBag)
        
        appointmentButton.rx.tap
            .subscribe(onNext: { [unowned self] (_) in
                self.viewModel.showTimetable()
            })
            .disposed(by: disposeBag)
    }
}
