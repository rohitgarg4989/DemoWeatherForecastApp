//
//  Weather.swift
//  DemoWeatherApp
//
//  Created by Rohit Garg on 1/5/19.
//  Copyright © 2019 Rohit Garg. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Weather {
    
    // MARK: - Properties

    var date: String?
    var time: String?
    var description: String?

    var temperature: Temperature?
    var temperatureMin: Temperature?
    var temperatureMax: Temperature?
    
    var forecastData: [WeatherForecast] = []
    
    // MARK: - init
    
    init(json: JSON) {
        initCurrentWeatherData(json: json)
        initWeatherForecastData(json: json)
    }
    
    private mutating func initCurrentWeatherData(json: JSON) {
        
        if let currentWeather = json["list"][0].dictionaryObject {
            
            if let dt = currentWeather["dt"] as? Double {
                date = Date.weatherDate(dt)
                time = Date.weatherTime(dt)
            }
            
            if let currentWeatherInfo = currentWeather["main"] as? [String: Any] {
                temperature = Temperature(tempInKelvin: currentWeatherInfo["temp"] as? Double)
                temperatureMin = Temperature(tempInKelvin: currentWeatherInfo["temp_min"] as? Double)
                temperatureMax = Temperature(tempInKelvin: currentWeatherInfo["temp_max"] as? Double)
            }
            
            if let currentWeatherDetail = currentWeather["weather"] as? [[String: Any]], currentWeatherDetail.count>0 {
                description = currentWeatherDetail[0]["description"] as? String
            }
            
        }
        
    }
    
    private mutating func initWeatherForecastData(json: JSON) {
        let jsonList = json["list"].arrayValue
        for index in 0...jsonList.count-1 {
            if index%8 == 0 {
                guard let weatherDictionary = jsonList[index].dictionaryObject else { return }
                let forecast = WeatherForecast(weatherDictionary: weatherDictionary)
                self.forecastData.append(forecast)
            }
        }
    }

}
