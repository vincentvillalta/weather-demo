//
//  WeatherService.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import UIKit
import PromiseKit
import Alamofire
import SwiftyJSON

struct WeatherService {
    private let apiKey = "46b1e86ad88e9e3a8ad377f17ecd5559"

    func requestWheatherForCoordinates(latitude: Double, longitude: Double) -> Promise<Weather> {
        return Promise { seal in
            //api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={your api key}
           AF.request("https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)").responseJSON { response in
                if let error = response.error {
                    seal.reject(error)
                }
                
                let json = JSON(response.data)
            print(json)
                seal.fulfill(Weather(json))
            }
            
           
        }
    }

}
