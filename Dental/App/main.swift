//
//  main.swift
//  Dental
//
//  Created by Igor Sorokin on 03.04.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

var appClass: String?
var appDelegateClass: String

if NSClassFromString("XCTestCase") == nil {
    appDelegateClass = NSStringFromClass(AppDelegate.self)
} else {
    assertionFailure("Not implemented")
    appDelegateClass = NSStringFromClass(AppDelegate.self)
}

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, appClass, appDelegateClass)
