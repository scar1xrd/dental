//
//  RoutingItem.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import UIKit

/// Marker protocol for items factory. Represents a module type in your app.
protocol RoutingItem {}

/// Marker protocol of items to use in modal presenting
protocol ModalRoutingItem: RoutingItem {}

/// Marker protocol of items to use in root routing
protocol RootRoutingItem: RoutingItem {
    var transition: CATransition? { get }
}

extension CATransition {
    static var fade: CATransition = {
        let transition = CATransition()
        transition.type = .fade
        return transition
    }()
}
