//
//  UIViewController+extension.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import UIKit

extension UIViewController {
    var topMostViewController: UIViewController? {
        if let self = self as? UITabBarController {
            return self.selectedViewController?.topMostViewController
        } else if let self = self as? UINavigationController {
            return self.visibleViewController?.topMostViewController
        } else if self.presentedViewController != nil {
            return self.presentedViewController?.topMostViewController
        }
        return self
    }
}
