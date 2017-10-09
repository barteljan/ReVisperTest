//
//  DispatcherProtocol.swift
//  WhoIsRight
//
//  Created by Jan Bartel on 08.10.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import ReactiveReSwift

public protocol DispatcherProtocol {
    func dispatch(_ actions: Action...)
}

extension Store : DispatcherProtocol {
    
}
