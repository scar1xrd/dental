//
//  BaseTabBarViewController.swift
//  Dental
//
//  Created by scar1xrd on 01/03/2020.
//  Copyright 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import RxSwift

class TabBarViewController: UITabBarController, View {
    // MARK: Private properties
    private let disposeBag: DisposeBag = .init()
    private var viewModel: TabBarViewModel!
    
    deinit {
        print("DEINIT \(self)")
    }
    
    override func loadView() {
        super.loadView()
        
        diTag = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

// MARK: - VIEW MODEL INJECTABLE

extension TabBarViewController: ViewModelInjectable {
    
    func set(viewModel: ViewModel) {
        self.viewModel = viewModel as? TabBarViewModel
    }
    
}

// MARK: - CONFIGURATIONS

private extension TabBarViewController {
    func configure() {
        configureView()
        configureControllers()
    }
    
    func configureView() {
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        tabBar.layer.shadowRadius = 6
        tabBar.layer.shadowOpacity = 0.5
        
        tabBar.tintColor = .dental
    }
    
    func configureControllers() {
        viewControllers = [viewModel.news, viewModel.branches]
    }

}
