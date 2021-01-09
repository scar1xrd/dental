//
//  RootRoutable.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import UIKit

protocol RootRoutable: class {
    var rootObject: Routable? { get }
    
    func setRoot(routable: Routable, animated: Bool, transition: CATransition)
}

extension RootRoutable {
    func setRoot(routable: Routable, animated: Bool) {
        setRoot(routable: routable, animated: animated, transition: .fade)
    }
}

extension UIWindow: RootRoutable {
    var rootObject: Routable? { return rootViewController }
    
    func setRoot(routable: Routable, animated: Bool, transition: CATransition) {
        
        if animated {
            layer.add(transition, forKey: kCATransition)
        }
        
        self.rootViewController = routable.object
        
        if UIView.areAnimationsEnabled && animated {
            UIView.animate(withDuration: transition.duration) {
                routable.object.setNeedsStatusBarAppearanceUpdate()
            }
        } else {
            routable.object.setNeedsStatusBarAppearanceUpdate()
        }
        
        makeKeyAndVisible()
    }
}
