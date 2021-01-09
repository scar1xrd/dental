//
//  BaseViewController.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle { return .default }

    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        diTag = nil
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func showHUD() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    func showAlert(
        title: String?,
        message: String? = nil,
        tintColor: UIColor = .dental,
        actionTitle: String = "Ок",
        completionHandler: (() -> Void)? = nil
    ) {
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            completionHandler?()
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = tintColor
        alert.addAction(action)
        
        if let popup = alert.popoverPresentationController {
            popup.sourceView = view
            popup.sourceRect = CGRect(origin: view.center, size: CGSize(width: 0, height: 0))
            popup.permittedArrowDirections = .up
        }
        
        present(alert, animated: true) {
            alert.view.tintColor = tintColor
        }
    }
}
