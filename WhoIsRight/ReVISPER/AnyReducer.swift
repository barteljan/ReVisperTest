//
//  AppReducer.swift
//  WhoIsRight
//
//  Created by Jan Bartel on 08.10.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import ReactiveReSwift

public struct AnyReducer {
    
    internal let reducer : Any
    
    public init<ReducerState>(_ reducer: @escaping Reducer<ReducerState>) {
        self.reducer = reducer
    }
    
    public func value<ReducerState>() -> Reducer<ReducerState>? {
        return self.reducer as? Reducer<ReducerState>
    }
    
}

public class ReducerContainer {
    
    internal var reducers = [AnyReducer]()
    
    public func add<ReducerState>(reducer: @escaping Reducer<ReducerState>){
        let anyReducer = AnyReducer(reducer)
        self.reducers.append(anyReducer)
    }
    
    public func reducers<ReducerState>(type: ReducerState.Type) -> [Reducer<ReducerState>] {
        
        var results = [Reducer<ReducerState>]()
        
        for anyReducer in self.reducers {
            
            if let typedReducer : Reducer<ReducerState> = anyReducer.value() {
                results.append(typedReducer)
            }
        }
        
        return results
    }
}
