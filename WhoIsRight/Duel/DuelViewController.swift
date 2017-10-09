//
//  DuelViewController.swift
//  WhoIsRight
//
//  Created by Jan Bartel on 07.10.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import RxSwift
import RxCocoa

class DuelViewController : UIViewController {
    
    var player1Button : UIButton!
    var player2Button : UIButton!
    var stateObservable : Observable<DuelStateProtocol>
    
    var disposeBag = DisposeBag()
    
    var wasRightObservable : Observable<PlayerWasRightAction>!
    
    public init(stateObservable : Observable<DuelStateProtocol>){
        
        self.stateObservable = stateObservable
        super.init(nibName: nil, bundle: nil)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
        self.player1Button = UIButton()
        self.view.addSubview(self.player1Button)
        self.player1Button.autoMatch(.height, to: .height, of: self.view, withMultiplier: 0.5)
        self.player1Button.autoPinEdges(toSuperviewMarginsExcludingEdge: .bottom)
        self.player1Button.setTitleColor(.blue, for: .normal)
        
        
        self.player2Button = UIButton()
        self.view.addSubview(self.player2Button)
        self.player2Button.autoMatch(.height, to: .height, of: self.view, withMultiplier: 0.5)
        self.player2Button.autoPinEdges(toSuperviewMarginsExcludingEdge: .top)
        self.player2Button.setTitleColor(.blue, for: .normal)
        
        
        self.bootstrapWasRightObservable()
        
        self.stateObservable.subscribe(onNext: { (state: DuelStateProtocol) in
            self.setState(duelState: state)
        }).addDisposableTo(self.disposeBag)
        
    }
    
    func bootstrapWasRightObservable() {
        
        self.wasRightObservable = Observable<PlayerWasRightAction>.create({ (observer: AnyObserver<PlayerWasRightAction>) -> Disposable in
            
            self.player1Button.rx.tap.subscribe(onNext: { _ in
                let action = PlayerWasRightAction(playerId: "1")
                observer.onNext(action)
            }).addDisposableTo(self.disposeBag)
            
            self.player2Button.rx.tap.subscribe(onNext: { _ in
                let action = PlayerWasRightAction(playerId: "2")
                observer.onNext(action)
            }).addDisposableTo(self.disposeBag)
            
            return Disposables.create()
        })
    }
    
    func setState(duelState: DuelStateProtocol) {
        
        if let button1 = self.player1Button {
            let title = "\(duelState.player1Name) hatte \(duelState.player1Counter) Mal recht"
            button1.setTitle(title, for: .normal)
        }
        
        if let button2 = self.player2Button {
            let title = "\(duelState.player2Name) hatte \(duelState.player2Counter) Mal recht"
            button2.setTitle(title, for: .normal)
        }
    }
}
