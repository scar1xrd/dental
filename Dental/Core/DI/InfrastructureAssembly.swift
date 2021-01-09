//
//  InfrastructureAssembly.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import EasyDi
import Foundation
import UIKit

final class InfrastructureAssembly: Assembly {
    private(set) lazy var routingItemsFactory: RoutingItemsFactory = context.assembly() as ModulesItemsFactory

    var itemsFactory: RoutingItemsFactory { define(init: self.routingItemsFactory) }
    
    var screen: UIScreen { define(init: UIScreen.main) }
    var bundle: Bundle { define(init: Bundle(for: InfrastructureAssembly.self)) }
    var fileManager: FileManager { define(init: FileManager.default) }
    var userDefaults: UserDefaults { define(init: UserDefaults.standard) }

    var window: UIWindow { define(
        scope: .lazySingleton,
        init: UIWindow(frame: self.screen.bounds)
    ) }
    
    var router: Router { define(
        scope: .lazySingleton,
        init: Router(rootRoutable: self.window, itemsFactory: self.routingItemsFactory)
    ) }
    
}
