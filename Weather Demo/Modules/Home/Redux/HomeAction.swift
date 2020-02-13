//
//  HomeAction.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import Foundation
import ReSwift
import PromiseKit
import ReSwiftThunk
import ReSwiftRouter
import CoreLocation

protocol HomeActionable: CustomAction {
    func reduce(state: inout HomeState)
}

enum HomeAction {
    struct Reset: HomeActionable {
        func reduce(state: inout HomeState) {
            state = .makeDefault()
        }
    }
    
    static func requestWeatherForLocation(location: CLLocationCoordinate2D, isCustomLocation: Bool) -> Thunk<AppState> {
        return Thunk<AppState> { dispatch, getState in
            dispatch(RequestWeatherTrigger())
            firstly {
                WeatherService().requestWheatherForCoordinates(latitude: location.latitude, longitude: location.longitude)
            }.done { response in
                
                dispatch(RequestWeatherSuccess(response))
                if isCustomLocation {
                    dispatch(SetRouteAction([homeRoute, details]))
                }
            }.catch { error in
                dispatch(RequestWeatherFailure(error))
            }
        }
    }
    
    struct RequestWeatherTrigger: HomeActionable {
        func reduce(state: inout HomeState) {
            state.isLoading = true
        }
    }
    
    struct RequestWeatherSuccess: HomeActionable {
        let response: Weather
        init(_ response: Weather) { self.response = response }
        func reduce(state: inout HomeState) {
            state.isLoading = false
            state.weather = response
        }
    }
    
    struct RequestWeatherFailure: HomeActionable {
        let error: Error
        init(_ error: Error) {
            print(error)
            self.error = error
        }
        
        func reduce(state: inout HomeState) {
            state.isLoading = false
        }
    }
}
