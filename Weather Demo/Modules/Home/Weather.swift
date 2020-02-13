//
//  Weather.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Weather: Equatable
{

    var condition: String
    var conditionDetail: String
    var temperature: Double?
    var feelsLike: Double?
    var maxTemp: Double?
    var minTemp: Double?
    var humidity: Int?
    var name: String?

}

extension Weather {
    init(_ object: JSON) {
        condition = object["weather"].arrayValue.first?.dictionaryValue["main"]?.stringValue ?? ""
        conditionDetail = object["weather"].arrayValue.first?.dictionaryValue["description"]?.stringValue ?? ""
        temperature = object["main"].dictionary?["temp"]?.double
        feelsLike = object["main"].dictionary?["feels_like"]?.double
        maxTemp = object["main"].dictionary?["temp_max"]?.double
        minTemp = object["main"].dictionary?["temp_min"]?.double
        humidity = object["main"].dictionary?["humidity"]?.int
        name = object["name"].string
    }
}
