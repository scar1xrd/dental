//
//  SplashViewController.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import UIKit
import RxSwift

protocol SplashView: View {}

class SplashViewController: BaseViewController, SplashView {
    // MARK: Private properties
    private let disposeBag: DisposeBag = .init()
    private var viewModel: SplashViewModel!
    
    deinit {
        print("DEINIT \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        view.backgroundColor = .red
    }
}

// MARK: - VIEW MODEL INJECTABLE

extension SplashViewController: ViewModelInjectable {
    func set(viewModel: ViewModel) {
        self.viewModel = viewModel as? SplashViewModel
    }
}

// MARK: - CONFIGURATIONS

private extension SplashViewController {
    func configure() {
        configureViews()
        configureHandlers()
    }
    
    func configureViews() {
        
    }
    
    func configureHandlers() {
        
    }
}
