//
//  HomeState.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

struct HomeState: StateType, Equatable {

    var isLoading: Bool
    var weather: Weather?

}

extension HomeState {
static func makeDefault() -> HomeState {
        return HomeState(
            isLoading: false,
            weather: nil
        )
    }
}
