//
//  EntryPoint.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import EasyDi

protocol EntryPoint {
    func run()
}

let entryPoint: EntryPoint = EntryPointImp.instance()

final class EntryPointImp: Assembly, EntryPoint {
    private lazy var infrastructure: InfrastructureAssembly = context.assembly()
    
    func run() {
        infrastructure.router.show(RootModuleItem.tabbar)
    }
}
