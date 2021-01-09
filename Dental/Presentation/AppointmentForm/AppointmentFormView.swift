//
//  AppointmentFormView.swift
//  Dental
//
//  Created by scar1xrd on 16/02/2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

class AppointmentFormView: UIView {
    private(set) weak var closeButton: CloseButton!
    private(set) weak var titleLabel: SLabel!
    private(set) weak var shadowView: UIView!
    private(set) weak var formView: FormView!
    private(set) weak var acceptButton: FillButton!
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let curvePath = CGMutablePath()
        curvePath.move(to: CGPoint(x: rect.minX, y: rect.midY))
        curvePath.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY - (rect.midY / 2)),
                               control: CGPoint(x: rect.midX + (rect.midX / 4), y: rect.midY))
        curvePath.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        curvePath.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        curvePath.closeSubpath()
        
        context?.addPath(curvePath)
        UIColor(red: 238/255, green: 144/255, blue: 50/255, alpha: 1.0).setFill()
        context?.fillPath()
    }
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowView.makeShadow(
            radius: 9,
            offset: CGSize(width: 0, height: 6),
            opacity: 0.1
        )
    }
    
    private func setupViews() {
        backgroundColor = .white
    
        let closeButton: CloseButton = {
            let view = CloseButton()
            return view
        }()
        
        let titleLabel: SLabel = {
            let view = SLabel()
            view.textStyle = LabelStyle.appTitle
            view.text = "Запись на прием"
            return view
        }()
        
        let shadowView: UIView = {
            let view = UIView()
            return view
        }()
        
        let formView: FormView = {
            let view = FormView()
            view.cornerRadius(20.0)
            return view
        }()
        
        let acceptButton: FillButton = {
            let view = FillButton()
            view.setTitle(L10n.Common.submit, for: .normal)
            return view
        }()
        
        self.closeButton = closeButton
        self.titleLabel = titleLabel
        self.shadowView = shadowView
        self.formView = formView
        self.acceptButton = acceptButton
        
        addSubview(self.closeButton)
        addSubview(self.titleLabel)
        addSubview(self.shadowView)
        addSubview(self.acceptButton)
        
        self.shadowView.addSubview(self.formView)
    }
    
    private func setupConstraints() {
        let safeArea = UIApplication.shared.keyWindow?.safeAreaInsets
        
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20.0 + (safeArea?.top ?? 0))
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(34.0)
        }
        
        shadowView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(5.0 / 8.0)
        }
        
        formView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(formView)
            $0.bottom.equalTo(formView.snp.top).offset(-8)
        }
        
        acceptButton.snp.makeConstraints {
            $0.top.equalTo(formView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
    }
}
