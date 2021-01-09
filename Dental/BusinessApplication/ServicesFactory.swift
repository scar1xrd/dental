//
//  ServicesFactory.swift
//  Dental
//
//  Created by Igor Sorokin on 08.12.2019.
//  Copyright © 2019 Igor Sorokin. All rights reserved.
//

import EasyDi
import Alamofire

final class ServicesFactory: Assembly {
    private lazy var repositoriesFactory: RepositoriesFactory = self.context.assembly()
    
    private var mapper: Mapper { define(init: MapperImp()) }
    
    // MARK: Services
    
    var splashService: SplashService { define(init: SplashServiceImp(
        externalRepository: self.repositoriesFactory.externalRepository,
        mapper: self.mapper
    )) }
    
    #if MOCK
    var newsService: NewsService { define(init: MockNewsService(
        mockRepository: self.repositoriesFactory.mockRepository,
        mapper: self.mapper
    )) }
    
    var receptionService: ReceptionService { define(init: MockReceptionService(
        mockRepository: self.repositoriesFactory.mockRepository,
        mapper: self.mapper
    )) }
    
    #else
    var newsService: NewsService { define(init: NewsServiceImp(
        externalRepository: self.repositoriesFactory.externalRepository,
        mapper: self.mapper
    )) }
    
    var receptionService: ReceptionService { define(init: ReceptionServiceImp(
        externalRepository: self.repositoriesFactory.externalRepository,
        mapper: self.mapper
    )) }
    #endif
    
}
