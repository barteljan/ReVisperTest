//
//  ReFeature.swift
//  WhoIsRight
//
//  Created by Jan Bartel on 08.10.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER
import RxSwift
import ReactiveReSwift

open class ReFeature<State> : VISPERFeature, ReducerProvider {
    
    internal let routePattern : String
    internal let stateObservable : Observable<State>
    open var dispatcher : DispatcherProtocol!
    
    public typealias ReducerState = State
    
    public init(routePattern : String,
             stateObservable : Observable<State>){
        
        self.routePattern = routePattern
        self.stateObservable = stateObservable
        super.init()
        self.addRoutePattern(routePattern)
        
    }
    
    open func stateType() -> Any.Type {
        return State.self
    }
    
    open override func controller(forRoute routePattern: String,
                                  routingOptions options: IVISPERRoutingOption,
                                  withParameters parameters: [AnyHashable : Any]) -> UIViewController? {
        
        if(self.routePattern == routePattern) {
            
            return self.createController(forRoute: routePattern,
                                         routingOptions: options,
                                         withParameters: parameters)
        }
        
        return nil
    }
    
    
    
    open override func option(forRoutePattern routePattern: String,
                              parameters: [AnyHashable : Any],
                              currentOptions: IVISPERRoutingOption?) -> IVISPERRoutingOption? {
        
        if let currentOptions = currentOptions {
            return currentOptions
        }
        
        if(routePattern == self.routePattern) {
            
            return self.createOption(forRoutePattern:routePattern,
                                     parameters:parameters,
                                     currentOptions:currentOptions)
            
        }
        
        return nil
    }
    
    open func createController(forRoute routePattern: String,
                              routingOptions options: IVISPERRoutingOption,
                           withParameters parameters: [AnyHashable : Any]) -> UIViewController {
        
        fatalError("you have to implement createController(routePattern:options:parameters:) in your feature")
    }
    
    
    open func createOption(forRoutePattern routePattern: String,
                                  parameters dictionary: [AnyHashable : Any],
                                  currentOptions: IVISPERRoutingOption?) -> IVISPERRoutingOption {
        fatalError("you have to implement createOption(routePattern:dictionary:currentOptions:) in your feature")
    }
    
    
    open func reducers() -> [Reducer<State>] {
        return  [Reducer<State>]()
    }
    

}
