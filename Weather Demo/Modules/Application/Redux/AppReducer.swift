//
//  AppReducer.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftRouter

func appReducer(action: Action, state: AppState?) -> AppState {
    
    var state = AppState(
        navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
        homeState: homeReducer(state: state?.homeState, action: action)
    )

    switch action {
    case let action as AppActionable:
        action.reduce(state: &state)
    default:
        break
    }
    
    return state
}
