//
//  RoutingItems.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import UIKit

enum RootModuleItem: RootRoutingItem {
    case splash
    case tabbar
    
    var transition: CATransition? {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = .fade
        return transition
    }
}

enum SingleModuleItem: RoutingItem {
    case news
    case newsDetails
    case branches
    case dentists
    case dentistDetails
}

enum ModalModuleItem: ModalRoutingItem {
    case timetable
    case appointmentForm
}
