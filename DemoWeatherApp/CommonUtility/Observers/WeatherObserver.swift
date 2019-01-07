//
//  WeatherObserver.swift
//  DemoWeatherApp
//
//  Created by Rohit Garg on 1/5/19.
//  Copyright © 2019 Rohit Garg. All rights reserved.
//

import Foundation

/// A struct representing value change event.
public struct Value<T> {
    
    public let value: T
    
    public init(_ value: T) {
        self.value = value
    }
    
}

public final class WeatherObserver<T> {
    
    typealias WeatherObserver = (T) -> Void
    
    var observer: WeatherObserver?
    
    var value: T {
        didSet {
            observer?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func observe(_ observer: WeatherObserver?) {
        self.observer = observer
        observer?(value)
    }
}
