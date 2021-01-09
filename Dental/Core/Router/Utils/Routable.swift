//
//  Routable.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import UIKit

/// Marker protocol of configurable object
protocol Configurable: class {}

/// To retrive configurable object during routing to another view
protocol ConfigurableProvider {
    /// Object allowing configuring
    var configurable: Configurable? { get }
}

/// Marker protocol of routable object
protocol Routable {
    var object: UIViewController { get }
}

extension UIViewController: Routable {
    var object: UIViewController { return self }
}
