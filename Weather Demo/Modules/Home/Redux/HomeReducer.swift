//
//  HomeReducer.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

func homeReducer(state: HomeState?, action: Action) -> HomeState {
    var state = state ?? HomeState.makeDefault()
    
    switch action {
    case let action as HomeActionable:
        action.reduce(state: &state)
    default:
        break
    }
    
    return state
}
