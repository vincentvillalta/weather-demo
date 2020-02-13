//
//  Dependency.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftThunk

class Dependency {
    static let shared = Dependency()
    typealias SideEffect = Store<AppState>.SideEffect
    private let thunkMiddleware: Middleware<AppState> = createThunkMiddleware()
    private let sideEffectMiddleware: Middleware<AppState> = createSideEffectMiddleware(effects: [])
    
    func makeMiddleware() -> [Middleware<AppState>] {
        return [
            thunkMiddleware,
            asyncMiddleware,
            sideEffectMiddleware
        ]
    }
    
    lazy var store: Store<AppState> = {
        return Store(reducer: appReducer,
                     state: AppState(),
                     middleware: makeMiddleware(),
                     automaticallySkipsRepeats: true)
    }()
}
