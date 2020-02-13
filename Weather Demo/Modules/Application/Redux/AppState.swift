//
//  AppState.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftRouter

struct AppState: StateType {
    // Global items
    var navigationState: NavigationState = NavigationState()
    
    var homeState: HomeState = HomeState.makeDefault()
}
