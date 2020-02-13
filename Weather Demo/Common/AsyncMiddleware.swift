//
//  AsyncMiddleware.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import Foundation
import ReSwift

protocol AsyncActionable: CustomAction {
    func async(dispatch: @escaping DispatchFunction, state: AppState, getState: @escaping () -> AppState?)
}

let asyncMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            next(action)
            if let asyncAction = action as? AsyncActionable, let state = getState() {
                asyncAction.async(dispatch: dispatch, state: state, getState: getState)
            }
        }
    }
}

protocol CustomAction: Action {
    func shouldExecute(for state: AppState) -> Bool
}

extension CustomAction {
    
    func shouldExecute(for state: AppState) -> Bool {
        return true
    }
}
