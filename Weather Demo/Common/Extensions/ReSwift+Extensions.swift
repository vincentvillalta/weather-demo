//
//  ReSwift+Extensions.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import ReSwift

extension Store {
    public struct SideEffect {
        let invoke: (Action, State, @escaping DispatchFunction) -> Void
        
        public init<A: Action>(of actionType: A.Type,
                               handler: @escaping (A, State, @escaping DispatchFunction) -> Void) {
            self.invoke = { action, state, dispatch in
                guard let action = action as? A else { return }
                handler(action, state, dispatch)
            }
        }
        
        public init(ofAny actionTypes: [Action.Type],
            handler: @escaping (Action, State, @escaping DispatchFunction) -> Void) {
            self.invoke = { action, state, dispatch in
                guard actionTypes.contains(where: { $0 == type(of: action) }) else { return }
                handler(action, state, dispatch)
            }
        }
    }
}

public func createSideEffectMiddleware<State: StateType>(effects: [Store<State>.SideEffect]) -> Middleware<State> {
    return { dispatch, getState in
        return { next in
            return { action in
                next(action)
                guard let state = getState() else { return }
                effects.forEach{
                    $0.invoke(action, state, dispatch)
                }
            }
        }
    }
}
