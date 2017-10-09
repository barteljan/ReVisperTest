//
//  AppState.swift
//  WhoIsRight
//
//  Created by Jan Bartel on 08.10.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation

protocol AppStateProtocol : HasDuelState {
    
}

struct AppState {
    var duelState : DuelStateProtocol
}
