//
//  WeatherInfoService.swift
//  DemoWeatherApp
//
//  Created by Rohit Garg on 1/6/19.
//  Copyright © 2019 Rohit Garg. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

enum WeatherServiceError: Error {
    case unknown
    case urlError
    case failedRequest
    case invalidResponse
}

typealias WeatherServiceCompletionHandler = (JSON?, WeatherServiceError?) -> Void


final class WeatherInfoService {
    
    fileprivate let baseURLForecast = "http://api.openweathermap.org/data/2.5/forecast?"
    
    // MARK: - Public
    
    func requestWeatherForecast(forCity city: String,
                                completionHandler: @escaping WeatherServiceCompletionHandler) {
        
        // Create request URL
        guard let requestURL = createRequestURL(baseURL: baseURLForecast, city) else {
            completionHandler(nil, .urlError)
            return
        }
        print(requestURL)
        
        // Create Data Task
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            DispatchQueue.main.async {
                self.processWeatherData(data: data, response: response, error: error,
                                        completion: completionHandler)
            }
        }.resume()
        
    }
    
    // MARK: - Private
    
    private func createRequestURL(baseURL: String, _ city: String) -> URL? {
        
        guard var components = URLComponents(string:baseURLForecast) else {
            return nil
        }
        
        let appId = getOWMAppId()
        
        components.queryItems = [URLQueryItem(name:"q", value:city),
                                 URLQueryItem(name:"appid", value:appId)]
        
        return components.url
        
    }
    
    private func processWeatherData(data: Data?, response: URLResponse?, error: Error?,
                                    completion: WeatherServiceCompletionHandler) {
        
        if let _ = error {
            completion(nil, .failedRequest)
        }
        else if let data = data, let response = response as? HTTPURLResponse {
            
            if response.statusCode == 200 {
                do {
                    // Decode JSON
                    let json = try JSON(data: data)
                    completion(json, nil)
                    
                } catch {
                    completion(nil, .invalidResponse)
                }
                
            } else {
                completion(nil, .failedRequest)
            }
            
        }
        else {
            completion(nil, .unknown)
        }
        
    }
    
    // MARK: - Helper Methods
    
    private func getOWMAppId() -> String {
        // get OpenWeatherMap App Id from Info.plist
        let filePath = Bundle.main.path(forResource: "Info", ofType: "plist")!
        let parameters = NSDictionary(contentsOfFile:filePath)
        let appId = (parameters!["OWMAppId"]! as! String).trimmingCharacters(in: .whitespacesAndNewlines)
        return appId
    }
    
}
