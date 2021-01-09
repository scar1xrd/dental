//
//  DentistDetailsView.swift
//  Dental
//
//  Created by scar1xrd on 16/02/2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class DentistDetailsView: UIView {
    private(set) weak var backButton: BackButton!
    private(set) weak var dentistImageView: UIImageView!
    private(set) weak var nameLabel: SLabel!
    private(set) weak var vScrollView: UIScrollView!
    private(set) weak var vStackView: UIStackView!
    private(set) weak var aboutView: TitleDescView!
    private(set) weak var branchesView: CategoriesView!
    private(set) weak var experienceView: TitleDescView!
    private(set) weak var educationView: TitleDescView!
    private(set) weak var gradientView: GradientView!
    private(set) weak var appointmentButton: FillButton!
    
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
    
    //swiftlint:disable function_body_length
    private func setupViews() {
        backgroundColor = .app
        
        let backButton: BackButton = {
            let view = BackButton(type: .system)
            view.cornerRadius(19)
            return view
        }()
        
        let dentistImageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFill
            return view
        }()
        
        let nameLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.appTitle
            return view
        }()
        
        let vScrollView: UIScrollView = {
            let view = UIScrollView()
            view.backgroundColor = .clear
            return view
        }()
        
        let vStackView: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            return view
        }()
        
        let aboutView: TitleDescView = {
            let view = TitleDescView()
            view.backgroundColor = .app
            return view
        }()
        
        let branchesView: CategoriesView = {
            let view = CategoriesView()
            view.backgroundColor = .app
            return view
        }()
        
        let experienceView: TitleDescView = {
            let view = TitleDescView()
            view.backgroundColor = .app
            return view
        }()
        
        let educationView: TitleDescView = {
            let view = TitleDescView()
            view.backgroundColor = .app
            return view
        }()
        
        let gradientView: GradientView = {
            let view = GradientView()
            view.backgroundColor = .clear
            view.colorLocations = [0.7, 1.0]
            return view
        }()
        
        let appointmentButton: FillButton = {
            let view = FillButton()
            view.setTitle(L10n.Dentist.appointment, for: .normal)
            return view
        }()
        
        self.backButton = backButton
        self.dentistImageView = dentistImageView
        self.nameLabel = nameLabel
        self.vScrollView = vScrollView
        self.vStackView = vStackView
        self.aboutView = aboutView
        self.branchesView = branchesView
        self.experienceView = experienceView
        self.educationView = educationView
        self.gradientView = gradientView
        self.appointmentButton = appointmentButton
        
        addSubview(self.dentistImageView)
        addSubview(self.nameLabel)
        addSubview(self.vScrollView)
        addSubview(self.backButton)
        
        self.vScrollView.addSubview(self.vStackView)
        
        self.vStackView.addArrangedSubview(self.experienceView)
        self.vStackView.addArrangedSubview(self.branchesView)
        self.vStackView.addArrangedSubview(self.educationView)
        self.vStackView.addArrangedSubview(self.aboutView)
        
        addSubview(self.gradientView)
        self.gradientView.addSubview(self.appointmentButton)
    }
    
    private func setupConstraints() {
    
        backButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().offset(15)
            $0.width.height.equalTo(38)
        }
        
        dentistImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(snp.width)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(dentistImageView.snp.bottom).inset(20)
            $0.trailing.equalToSuperview().offset(20)
        }
        
        vScrollView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        vStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(vScrollView.snp.width)
        }
        
        gradientView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        appointmentButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
                .inset(UIEdgeInsets(top: 20, left: 20, bottom: safeAreaInsets.bottom + 16, right: 20))
            $0.height.equalTo(50)
        }
    }
}
