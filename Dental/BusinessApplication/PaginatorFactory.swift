//
//  PaginatorFactory.swift
//  Dental
//
//  Created by Igor Sorokin on 08.02.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import EasyDi

final class PaginatorFactory<T: Paginatable>: Assembly {
    
    var paginatorService: AnyPaginator<T> { define(init: AnyPaginator<T>(PaginatorImp())) }
    
}
