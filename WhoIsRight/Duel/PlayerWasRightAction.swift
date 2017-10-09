//
//  PlayerWasRightAction.swift
//  WhoIsRight
//
//  Created by Jan Bartel on 08.10.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import ReactiveReSwift

protocol PlayerWasRightActionProtocol : Action {
    var playerId : String {get}
}

struct PlayerWasRightAction : PlayerWasRightActionProtocol {
    var playerId : String
}
