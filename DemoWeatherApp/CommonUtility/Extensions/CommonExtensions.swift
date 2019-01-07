//
//  CommonExtensions.swift
//  DemoWeatherApp
//
//  Created by Rohit Garg on 1/5/19.
//  Copyright © 2019 Rohit Garg. All rights reserved.
//

import Foundation
import UIKit

// MARK: - String Helper Methods

extension String {
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension Optional where Wrapped == String {
    var isValidNonEmptyString: String? {
        if let unwrapped = self {
            return unwrapped.isBlank ? nil: unwrapped
        } else {
            return nil
        }
    }
}


// MARK: - UserDefaults Helper Methods

struct UserDefaultsKeys {
    static let kCity = "city"
    static let kIsCitySelected = "isCitySelected"
}

extension UserDefaults {
    
    class func bool(forKey key: String) -> Bool {
        return self.standard.bool(forKey: key)
    }
    
    class func setBool(value: Bool, forKey key: String) {
        self.standard.set(value, forKey: key)
    }
    
    class func setObject(object: Any, forKey key: String) {
        if let data:Data = NSKeyedArchiver.archivedData(withRootObject: object) as Data? {
            self.standard.set(data, forKey: key)
            self.standard.synchronize()
        }
        
    }
    
    class func getObject(forKey key: String) -> Any? {
        if let data = self.standard.object(forKey: key) as? Data {
            if let object:AnyObject = NSKeyedUnarchiver.unarchiveObject(with: data) as AnyObject? {
                return object
            }
        }
        return nil
    }
}

extension UIViewController {
    func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Demo Weather App", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension Date {
    
    static func weatherDate(_ dt: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd MMM"
        let date = Date(timeIntervalSince1970: dt)
        return dateFormatter.string(from: date)
    }
    
    static func weatherTime(_ dt: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh a"
        let date = Date(timeIntervalSince1970: dt)
        return dateFormatter.string(from: date)
    }
    
}
