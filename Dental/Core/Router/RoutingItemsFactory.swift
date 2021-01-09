//
//  RoutingItemsFactory.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import UIKit
import EasyDi

protocol RoutingItemsFactory {
    func routable(for item: RoutingItem) -> Routable?
}

final class ModulesItemsFactory: Assembly {
    private var splash: UIViewController { return define(init: SplashViewController()) }
    
    private var tabbar: UITabBarController {
        let tabbar = TabBarViewController()
        return define(init: tabbar)
    }
    
    // MARK: - News
    
    private var news: UINavigationController {
        let newsController = NewsViewController()
        let newsNavigation = BaseNavigationController(rootViewController: newsController)
        return define(init: newsNavigation)
    }
    
    private var newsDetails: UIViewController {
        let newsDetailsController = NewsDetailsViewController()
        return define(init: newsDetailsController)
    }
    
    // MARK: - Dentists
    
    private var branches: UINavigationController {
        let branchesController = BranchesViewController()
        let branchesNavigation = BaseNavigationController(rootViewController: branchesController)
        return define(init: branchesNavigation)
    }
    
    private var dentists: UIViewController {
        let dentistsController = DentistsViewController()
        return define(init: dentistsController)
    }
    
    private var dentistDetails: UIViewController {
        let dentistDetailsController = DentistDetailsViewController()
        dentistDetailsController.hidesBottomBarWhenPushed = true
        return define(init: dentistDetailsController)
    }
    
    private var timetable: UIViewController {
        let timtablePanelController = TimetablePanelController()
        return define(init: timtablePanelController)
    }
    
    private var appointmentForm: UIViewController {
        let appointmentFormController = AppointmentFormViewController()
        appointmentFormController.modalPresentationStyle = .fullScreen
        return define(init: appointmentFormController)
    }
    
}

extension ModulesItemsFactory: RoutingItemsFactory {
    
    func routable(for item: RoutingItem) -> Routable? {
        switch item {
        case let item as RootModuleItem:   return routableForRoot(item)
        case let item as SingleModuleItem: return routableForSingle(item)
        case let item as ModalModuleItem:  return routableForModal(item)
        default:
            return nil
        }
    }
    
    private func routableForRoot(_ item: RootModuleItem) -> Routable? {
        switch item {
            case .splash: return splash
            case .tabbar: return tabbar
        }
    }
    
    private func routableForSingle(_ item: SingleModuleItem) -> Routable? {
        switch item {
            case .news:                return news
            case .newsDetails:         return newsDetails
            case .branches:            return branches
            case .dentists:            return dentists
            case .dentistDetails:      return dentistDetails
        }
    }
    
    private func routableForModal(_ item: ModalModuleItem) -> Routable? {
        switch item {
            case .timetable:       return timetable
            case .appointmentForm: return appointmentForm
        }
    }
}
