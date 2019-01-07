//
//  Temperature.swift
//  DemoWeatherApp
//
//  Created by Rohit Garg on 1/6/19.
//  Copyright © 2019 Rohit Garg. All rights reserved.
//

import Foundation

struct Temperature {
    
    var degrees: String?
    
    init(tempInKelvin: Double?) {
        if let temp = tempInKelvin {
            // Since OWM api returns Temperature in Kelvin by default, need to convert it to celsius
            degrees = String(Temperature.kelvinToCelsius(temp)) + "\u{00B0}C"
        }
    }
    
    static func kelvinToCelsius(_ degrees: Double) -> Int {
        return Int(round(degrees - 273.15))
    }
    
    static func kelvinToFahrenheit(_ degrees: Double) -> Int {
        return Int(round(degrees * 9 / 5 - 459.67))
    }
    
}
