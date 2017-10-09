//
//  DuelState.swift
//  WhoIsRight
//
//  Created by Jan Bartel on 08.10.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation

protocol DuelStateProtocol {
    
    var player1Name : String {get}
    var player2Name : String {get}
    var player1Counter : Int {get}
    var player2Counter : Int {get}
    
}

protocol HasDuelState {
    var duelState : DuelStateProtocol {get}
}

struct DuelState : DuelStateProtocol {
    
    var player1Name : String
    var player2Name : String
    var player1Counter : Int
    var player2Counter : Int
    
}
