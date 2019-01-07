//
//  WeatherInfoViewModel.swift
//  DemoWeatherApp
//
//  Created by Rohit Garg on 1/6/19.
//  Copyright © 2019 Rohit Garg. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherInfoViewModel {
    
     // MARK: - Properties
    
    var location: String = {
        return ""
    }()
    
    fileprivate lazy var weatherService = {
        return WeatherInfoService()
    }()
    
    let errorMessage: WeatherObserver<String?>
    let weatherInfo: WeatherObserver<Weather?>
    
    // MARK: - init
    
    init() {
        errorMessage = WeatherObserver(nil)
        weatherInfo = WeatherObserver(nil)
        location = self.getSelectedCity()
    }
    
    // MARK: - public
    
    func requestWeatherInfo() {
        
        weatherService.requestWeatherForecast(forCity: location) { (json, error) in
            DispatchQueue.main.async(execute: {
                
                if let error = error {
                    self.updateViewModelWithError(error)
                    return
                }
                
                guard let json = json else { return }
                
                let weatherInfo: Weather = Weather(json: json)
                self.updateViewModelWithWeatherInfo(weatherInfo)
                
            })
        }
        
    }
    
    // MARK: - private
    
    private func updateViewModelWithError(_ error: WeatherServiceError) {
        
        switch error {
        case .unknown:
            self.errorMessage.value = "Something went wrong!"
        case .urlError:
            self.errorMessage.value = "The weather service is not working!"
        case .failedRequest:
            self.errorMessage.value = "Network appears to be down. Try again later!"
        case .invalidResponse:
            self.errorMessage.value = "We're having trouble processing weather data!"
        }
        
        self.weatherInfo.value = nil
        
    }
    
    private func updateViewModelWithWeatherInfo(_ weather: Weather) {
        self.errorMessage.value = nil
        self.weatherInfo.value = weather
    }
    
    private func getSelectedCity() -> String {
        if let city = UserDefaults.getObject(forKey: UserDefaultsKeys.kCity) as? String {
            return city
        }
        return ""
    }
    
}
