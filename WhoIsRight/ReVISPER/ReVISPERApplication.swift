//
//  ReApplication.swift
//  WhoIsRight
//
//  Created by Jan Bartel on 08.10.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER
import ReactiveReSwift
import RxSwift

enum ReVISPERApplicationError : Error {
    case createStoreWithNoInitialState
}

public protocol ReVisperApplicationProtocol : IVISPERApplication {
    
    associatedtype AppStateType
    
    //MARK: reactive store management
    func reStore() throws -> Store<Variable<AppStateType>>
    func updateReStore() throws
    
    //MARK: manage reducers
    func add<ReducerState>(reducer: @escaping Reducer<ReducerState>)
    func reducers<ReducerState>(type: ReducerState.Type) -> [Reducer<ReducerState>]
    
    //MARK: feature management
    func add<State>(_ feature: ReFeature<State>) throws
    
    //MARK: state management
    func applyActionToAllReducersOfState<StateType>(action: Action,state: StateType) -> StateType
    
}

open class ReVISPERApplication<State> : VISPERApplication, ReVisperApplicationProtocol{
    
    public typealias AppStateType = State
    
    internal var reducerContainer = ReducerContainer()
    
    internal let mainReducer : (_ reducerContainer: ReducerContainer, _ action: Action,_ state : State) -> State
    
    internal var disposeBag = DisposeBag()
    
    open var state : Variable<State>?
    
    //MARK: intializer
    public init!(       initialState: Variable<State>,
                         mainReducer: @escaping (_ reducerContainer: ReducerContainer, _ action: Action,_ state : State) -> State,
     navigationController controller: UINavigationController! = UINavigationController(),
                           wireframe: IVISPERWireframe! = VISPERWireframe(),
                          commandBus: VISPERCommandBus! = VISPERCommandBus()) {
        self.mainReducer = mainReducer
        self.state = initialState
        super.init(navigationController: controller, wireframe: wireframe, commandBus: commandBus)
    }
    
    //MARK: reactive store management
    internal var _reStore : Store<Variable<State>>?
    open func reStore() throws -> Store<Variable<State>> {
        
        if( self._reStore == nil ){
            try self.updateReStore()
        }
        
        return self._reStore!
    }
    
    open func updateReStore() throws {
        
        var stateObservable : Variable<State>
        
        if let state = self.state {
            stateObservable = state
        }else {
            throw ReVISPERApplicationError.createStoreWithNoInitialState
        }
        
        let appReducer : Reducer<State> = {action, state in
            return self.mainReducer(self.reducerContainer, action, state)
        }
        
        self._reStore = Store<Variable<State>>(reducer: appReducer, observable: stateObservable)
    }
  
    //MARK: manage reducers
    open func add<ReducerState>(reducer: @escaping Reducer<ReducerState>){
        self.reducerContainer.add(reducer: reducer)
    }
    
    open func reducers<ReducerState>(type: ReducerState.Type) -> [Reducer<ReducerState>] {
        return self.reducerContainer.reducers(type: type)
    }
    
    //MARK: feature management
    open func add<State>(_ feature: ReFeature<State>) throws {
        
        super.add(feature)
        
        for reducer in feature.reducers() {
            self.reducerContainer.add(reducer: reducer)
        }
        
        try self.updateReStore()
        feature.dispatcher = try self.reStore()
        
    }
    
    //MARK: state management
    open func applyActionToAllReducersOfState<StateType>(action: Action,state: StateType) -> StateType {
        
        var newState = state
        
        for reducer in self.reducerContainer.reducers(type: StateType.self) {
            newState = reducer(action, newState)
        }
        
        return newState
        
    }
    
    
    
    
}

