//
//  LocationManager.swift
//  DemoWeatherApp
//
//  Created by Rohit Garg on 1/5/19.
//  Copyright © 2019 Rohit Garg. All rights reserved.
//

import Foundation
import CoreLocation

// location manager completion handler
public typealias LocationCompletionHandler = (String?, NSError?) -> Void

class LocationManager: NSObject {
    
    // MARK: -
    
    lazy var geocoder = CLGeocoder()
    
    // MARK: -

    public func getCountryName(forCity location: String, completionHandler: @escaping LocationCompletionHandler) {
        
        geocoder.geocodeAddressString(location, completionHandler: {(placemarks: [CLPlacemark]?, error: Error?) -> Void in
            
            if error != nil {
                // An error occurred during geocoding.
                print("Unable to Reverse Geocode Location (\(error!))")
                completionHandler(nil, error as NSError?)
            }
            else {
                if ((placemarks?.count)! > 0) {
                    let placemark: CLPlacemark = (placemarks?.first)!
                    let country : String = placemark.country!
                    completionHandler(country, nil)
                } else {
                    // No Country available for entered city.
                    print("No Matching Country Found")
                    completionHandler(nil, nil)
                }
            }
            
        } )
        
    }
    
}
