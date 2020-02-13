//
//  AppAction.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import ReSwift
import ReSwiftThunk
import PromiseKit

protocol AppActionable: CustomAction {
    func reduce(state: inout AppState)
}

enum AppAction {
    static func requestUserLocation() -> Thunk<AppState> {
        return Thunk<AppState> {_,_ in
            
        }
    }
}
