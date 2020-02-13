//
//  HomeViewController.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter
import CoreLocation

class HomeViewController: UIViewController {

    private let store: Store<AppState>
    private var state: HomeState?
    private lazy var homeView: HomeView = {
        let view = HomeView()
        view.delegate = self
        return view
    }()

    init(store: Store<AppState> = Dependency.shared.store) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.dispatch(HomeAction.requestWeatherForLocation(location: CLLocationCoordinate2D(latitude: 39.0, longitude: 9.0), isCustomLocation: false))
        
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            let locationManager = CLLocationManager()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
    }
}

extension HomeViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = HomeState
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self) { state in
            return state.select({$0.homeState}).skipRepeats()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
    
    func newState(state: StoreSubscriberStateType) {
        self.state = state
        let viewModel = HomeViewModel(state)
        homeView.update(viewModel: viewModel)
    }
}

extension HomeViewController: HomeViewDelegate {
    func showUserLocationWheather(coordinates: CLLocationCoordinate2D) {
        store.dispatch(HomeAction.requestWeatherForLocation(location: coordinates, isCustomLocation: false))
    }
    
    func showLocationWeather(coordinates: CLLocationCoordinate2D) {
        store.dispatch(HomeAction.requestWeatherForLocation(location: coordinates, isCustomLocation: true))
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //print(status)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            store.dispatch(HomeAction.requestWeatherForLocation(location: location.coordinate, isCustomLocation: false))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //print(error)
    }
}
