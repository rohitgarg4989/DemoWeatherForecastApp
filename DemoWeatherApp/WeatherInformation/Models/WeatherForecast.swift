//
//  WeatherForecast.swift
//  DemoWeatherApp
//
//  Created by Rohit Garg on 1/5/19.
//  Copyright © 2019 Rohit Garg. All rights reserved.
//

import Foundation

struct WeatherForecast {
    
    // MARK: - Properties

    var date: String?
    var time: String?
    var description: String?
    var temperatureMin: Temperature?
    var temperatureMax: Temperature?
    
    // MARK: - init
    
    init(weatherDictionary: [String: Any]) {
        
        if let dt = weatherDictionary["dt"] as? Double {
            date = Date.weatherDate(dt)
            time = Date.weatherTime(dt)
        }
        
        if let currentWeatherInfo = weatherDictionary["main"] as? [String: Any] {
            temperatureMin = Temperature(tempInKelvin: currentWeatherInfo["temp_min"] as? Double)
            temperatureMax = Temperature(tempInKelvin: currentWeatherInfo["temp_max"] as? Double)
        }
        
        if let currentWeatherDetail = weatherDictionary["weather"] as? [[String: Any]], currentWeatherDetail.count>0 {
            description = currentWeatherDetail[0]["description"] as? String
        }
        
    }
    
}
