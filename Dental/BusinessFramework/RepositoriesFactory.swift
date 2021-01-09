//
//  RepositoryFactory.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import EasyDi
import Alamofire

final class RepositoriesFactory: Assembly {
    private lazy var infrastructure: InfrastructureAssembly = context.assembly()
    
    private var sessionManager: Session { define(init: Session.default) }
    
    var externalRepository: ExternalRepository { define(
        init: ExternalRepositoryImp(session: self.sessionManager)
    ) }
    
    var mockRepository: MockRepository { define(
        init: MockRepositoryImp(bundle: self.infrastructure.bundle)
    ) }
    
    var internalRepository: InternalRepository { define(init: self.infrastructure.userDefaults) }
    
}
