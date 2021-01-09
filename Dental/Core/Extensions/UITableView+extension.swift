//
//  UITableView+extension.swift
//  Dental
//
//  Created by Igor Sorokin on 06.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

extension UITableView {
    func register<T: UITableViewCell>(cellClass: T.Type) {
        self.register(
            cellClass.self,
            forCellReuseIdentifier: String(describing: cellClass.self)
        )
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }
    
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(viewClass: T.Type) {
        self.register(
            viewClass,
            forHeaderFooterViewReuseIdentifier: String(describing: viewClass.self)
        )
    }
    
    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let cell = self.dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }
    
    func addPagination(actionRelay: PublishRelay<Void>) -> Disposable {
        self.rx.contentOffset
            .subscribe(onNext: { [unowned self] (point) in
                let offset = point.y
                let contentSize = self.contentSize.height
                let height = self.frame.height
                
                if (offset > contentSize - height - 150) && offset > 0 {
                    actionRelay.accept(())
                }
            })
    }
}
