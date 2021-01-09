//
//  Router.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import Foundation

final class Router {
    private let rootRoutable: RootRoutable
    private let routingItemsFactory: RoutingItemsFactory
    
    init(rootRoutable: RootRoutable, itemsFactory: RoutingItemsFactory) {
        self.rootRoutable = rootRoutable
        self.routingItemsFactory = itemsFactory
    }
    
    func show(
        _ item: RoutingItem,
        animated: Bool = true,
        configuration: ((Configurable) -> Void)? = nil
    ) {
        guard let routable = routingItemsFactory.routable(for: item) else { return }
        
        if let item = item as? RootRoutingItem {
            if let transition = item.transition {
                rootRoutable.setRoot(routable: routable, animated: animated, transition: transition)
            } else {
                rootRoutable.setRoot(routable: routable, animated: animated)
            }
        } else if item is ModalRoutingItem {
            rootRoutable.rootObject?.object.topMostViewController?.present(routable.object, animated: animated)
        } else if let nvc = rootRoutable.rootObject?.object.topMostViewController?.navigationController {
            nvc.pushViewController(routable.object, animated: animated)
        }
        
        if let configurable = (routable as? ConfigurableProvider)?.configurable {
            configuration?(configurable)
        }
    }
    
    func dismissModal(animated: Bool = true, completion: (() -> Void)? = nil) {
        let topVC = rootRoutable.rootObject?.object.topMostViewController
        topVC?.presentingViewController?.dismiss(animated: animated, completion: completion)
    }
    
    func close(animated: Bool = true) {
        let topVC = rootRoutable.rootObject?.object.topMostViewController
        if let nvc = topVC?.navigationController {
            nvc.popViewController(animated: animated)
        } else {
            dismissModal(animated: animated)
        }
    }
    
    func closeAllInStack(animated: Bool = true) {
        let topVC = rootRoutable.rootObject?.object.topMostViewController
        guard let nvc = topVC?.navigationController else { return }
        nvc.popToRootViewController(animated: animated)
    }
}
