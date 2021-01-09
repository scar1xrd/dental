//
//  AppDelegate.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityLogger
import IQKeyboardManagerSwift

final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
        IQKeyboardManager.shared.enable = true
        
        entryPoint.run()
        
        return true
    }
}
