//
//  HomeView.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation
protocol HomeViewDelegate: class {
    func showUserLocationWheather(coordinates: CLLocationCoordinate2D)
    func showLocationWeather(coordinates: CLLocationCoordinate2D)
}

class HomeView: View {
    weak var delegate: HomeViewDelegate?
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap(_:)))
        gestureRecognizer.numberOfTapsRequired = 2
        gestureRecognizer.numberOfTouchesRequired = 1
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
        return mapView
    }()
    
    private lazy var weaterContainer: WeatherView = {
        return WeatherView()
    }()
    
    func update(viewModel: HomeViewModel) {
        guard let weather = viewModel.currentWheather else { return }
        weaterContainer.update(weather: weather)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {

        let location = sender.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        delegate?.showLocationWeather(coordinates: coordinate)
    }
    
    override func customInit() {
        super.customInit()
        
        addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(weaterContainer)
        weaterContainer.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    

}

extension HomeView: UIGestureRecognizerDelegate {
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let t = touches.first
          var tempView = t?.view
          while tempView != self {
              if tempView != mapView {
                  tempView = tempView?.superview!
              }else if tempView == mapView{
                  break
              }

          }
        let convertedCoor = mapView.convert((t?.location(in: mapView))!, toCoordinateFrom: mapView)
        delegate?.showLocationWeather(coordinates: convertedCoor)
    }
}
