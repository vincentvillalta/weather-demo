//
//  HomeViewModel.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import UIKit

struct HomeViewModel {

    var currentWheather: Weather?

}

extension HomeViewModel {
    init(_ state: HomeState) {
        currentWheather = state.weather
    }
}
