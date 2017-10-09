//
//  ReducerProvider.swift
//  WhoIsRight
//
//  Created by Jan Bartel on 08.10.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import ReactiveReSwift

public protocol AnyReducerProvider {
    
}

public protocol ReducerProvider : AnyReducerProvider{
    associatedtype ReducerState
    
    func reducers() -> [Reducer<ReducerState>]
}
