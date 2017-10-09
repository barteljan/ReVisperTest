//
//  AppDelegate.swift
//  WhoIsRight
//
//  Created by Jan Bartel on 07.10.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import UIKit
import VISPER
import ReactiveReSwift
import RxSwift

enum Routes : String {
    case duel = "duel"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var visperApplication : ReVISPERApplication<AppState>!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window  = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let duelState = DuelState(player1Name: "Jan",
                                  player2Name: "Lisanne",
                                  player1Counter: 0,
                                  player2Counter: 0)
        
        let appState = AppState(duelState: duelState)
        
        self.visperApplication = ReVISPERApplication<AppState>( initialState : Variable(appState),
                                                                 mainReducer : { container, action ,state  in
            let newState = AppState(duelState: self.visperApplication.applyActionToAllReducersOfState(action: action,state: state.duelState))
            return newState
        })
        
        //self.visperApplication.state =
        
        window.rootViewController = self.visperApplication.rootViewController()
        self.visperApplication.navigationController().navigationBar.isTranslucent = false
        
        do {
            try self.bootstrapDuel()
        } catch let error {
            fatalError("Error: \(error)")
        }
        
        self.visperApplication.routeURL(URL(string:Routes.duel.rawValue)!,
                                    withParameters: nil,
                                           options: nil)
        
        window.makeKeyAndVisible()
        
        return true
    }
    
    
    

    func bootstrapDuel() throws {
        
        let duelStateObservable = try! self.visperApplication.reStore().observable.asObservable().map { appState -> DuelStateProtocol in
            return appState.duelState
        }
        
        let feature = DuelFeature(routePattern: Routes.duel.rawValue,
                               stateObservable: duelStateObservable)
        
        try self.visperApplication.add(feature)
        
    }
    
}

