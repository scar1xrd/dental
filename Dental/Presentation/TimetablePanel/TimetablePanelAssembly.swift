//
//  FloatingPanelAssembly.swift
//  Dental
//
//  Created by scar1xrd on 16/02/2020.
//  Copyright 2020 Igor Sorokin. All rights reserved.
//

import EasyDi
import FloatingPanel

final class FloatingPanelAssembly: Assembly, ResolvingAssembly {
    private lazy var infrastructure: InfrastructureAssembly = context.assembly()
    
    private var view: View { definePlaceholder() }
    private var contentView: View & ViewModelInjectable { define(init: DentistTimetableViewController()) }
    
    func inject(into view: TimetablePanelController) {
        defineInjection(key: "view", into: view) { [unowned self] in
            let dentistTimetableController = self.contentView as? DentistTimetableViewController
            $0.set(contentViewController: dentistTimetableController)
            $0.track(scrollView: dentistTimetableController?.collectionView)
            return $0
        }
    }
}

extension TimetablePanelController: InstantiatableAssembly {
    typealias InstantiationAssembly = FloatingPanelAssembly
}
