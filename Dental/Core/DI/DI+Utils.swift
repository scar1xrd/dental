//
//  DI+Utils.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import EasyDi

/// Marker protocol for view
protocol View {}

/// Marker protocol for view model
public protocol ViewModel {}

/// To inject view model into a view
public protocol ViewModelInjectable: class {
    /// Injects view model into a view. The view must implement this method
    ///
    /// - Parameter viewModel: concrete view model
    func set(viewModel: ViewModel)
}

protocol Injectable: class {
    var assembly: AnyResolvingAssembly { get }
}

protocol InstantiatableAssembly: Injectable {
    associatedtype InstantiationAssembly: Assembly & ResolvingAssembly
}

extension InstantiatableAssembly {
    public var assembly: AnyResolvingAssembly {
        return DIContext.defaultInstance.assembly() as InstantiationAssembly
    }
}

protocol ResolvingAssembly: AnyResolvingAssembly {
    associatedtype Instance
    func inject(into view: Instance)
}

extension ResolvingAssembly {
    func inject(into any: AnyObject) {
        guard let concrete = any as? Instance else {
            fatalError()
        }
        inject(into: concrete)
    }
}

protocol AnyResolvingAssembly {
    func inject(into view: AnyObject)
}

// swiftlint:disable unused_setter_value
extension NSObject {
    var diTag: Any? {
        get { return nil }
        set {
            if let injectable = self as? Injectable {
                injectable.assembly.inject(into: self)
            }
        }
    }
}
