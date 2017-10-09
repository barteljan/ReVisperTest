//
//  DuelReducer.swift
//  WhoIsRight
//
//  Created by Jan Bartel on 08.10.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import ReactiveReSwift

let duelReducer : Reducer<DuelStateProtocol> = {action, duelState in
    
    if let action = action as? PlayerWasRightActionProtocol{
        
        var newState = DuelState(player1Name: duelState.player1Name,
                                 player2Name: duelState.player2Name,
                                 player1Counter: duelState.player1Counter,
                                 player2Counter: duelState.player2Counter)
        
        switch(action.playerId){
        case "1":
            newState.player1Counter = duelState.player1Counter + 1
            break
        case "2":
            newState.player2Counter = duelState.player2Counter + 1
            break
        default:
            break
        }
        
        return newState
    }
    
    return duelState
}
