//
//  TabBarViewModel.swift
//  Dental
//
//  Created by scar1xrd on 01/03/2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

protocol TabBarViewModel: ViewModel {
    var news: UIViewController! { get }
    var branches: UIViewController! { get }
}

class TabBarViewModelImp: TabBarViewModel {
    
    // MARK: View Controllers
    var news: UIViewController!
    var branches: UIViewController!
    
    init(news: UIViewController, branches: UIViewController) {
        self.news = news
        self.branches = branches
        
        configureControllers()
    }
    
    deinit {
        print("DEINIT \(self)")
    }
    
    private func configureControllers() {
        news.tabBarItem = UITabBarItem(
            title: L10n.News.title,
            image: Asset.Tabbar.collection.image,
            selectedImage: nil
        )
        
        branches.tabBarItem = UITabBarItem(
            title: L10n.Branches.tabbarTitle,
            image: Asset.Tabbar.health.image,
            selectedImage: nil
        )
    }
    
}
