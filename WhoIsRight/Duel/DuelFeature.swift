//
//  DuelFeature.swift
//  WhoIsRight
//
//  Created by Jan Bartel on 08.10.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER
import UIKit
import RxSwift
import ReactiveReSwift

class DuelFeature : ReFeature<DuelStateProtocol> {
    
    override func createController(forRoute routePattern: String,
                            routingOptions options: IVISPERRoutingOption,
                         withParameters parameters: [AnyHashable : Any]) -> UIViewController {
        
        let controller = DuelViewController(stateObservable: self.stateObservable)
        _ = controller.view
        
        controller.wasRightObservable.subscribe(onNext: { (action : PlayerWasRightAction) in
            self.dispatcher.dispatch(action)
        }).addDisposableTo(controller.disposeBag)
        
        return controller
        
    }
    
    override func createOption(forRoutePattern routePattern: String,
                                parameters dictionary: [AnyHashable : Any],
                                       currentOptions: IVISPERRoutingOption?) -> IVISPERRoutingOption {
        
     
        return VISPER.routingOptionPush()
       
    }
    
    override func reducers() -> [(Action, DuelStateProtocol) -> DuelStateProtocol] {
        return [duelReducer]
    }
    
}
