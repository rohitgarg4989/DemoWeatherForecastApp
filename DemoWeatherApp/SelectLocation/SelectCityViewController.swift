//
//  SelectCityViewController.swift
//  DemoWeatherApp
//
//  Created by Rohit Garg on 1/5/19.
//  Copyright © 2019 Rohit Garg. All rights reserved.
//

import UIKit

class SelectCityViewController: UIViewController {
    
    // MARK: - Constants
    
    private let kSegueWeather = "SegueWeatherVC"
    private let kErrorMessageInvalidCity = "Invalid location. \nPlease enter valid city!"
    

    // MARK: - Properties
    
    @IBOutlet weak var textFieldCity: UITextField!
    @IBOutlet weak var btnVerifyLocation: UIButton!
    @IBOutlet weak var labelErrorMessage: UILabel!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     // MARK: - Actions
    
    @IBAction func btnVerifyClicked(_ sender: UIButton) {
        
        textFieldCity.resignFirstResponder()
        
        guard let city = textFieldCity.text.isValidNonEmptyString else {
            // Alert: textField is empty!
            self.showAlert(withMessage: "Please Enter City!")
            return
        }
        
        verifyLocation(city)
    }
    
    // MARK: - Helper Methods
    
    private func verifyLocation(_ inputCity: String) {
        
        btnVerifyLocation.isHidden = true
        labelErrorMessage.isHidden = true
        activityIndicatorView.startAnimating()
        
        let locationManager = LocationManager()
        locationManager.getCountryName(forCity: inputCity) { (country, error) in
            
            self.btnVerifyLocation.isHidden = false
            self.activityIndicatorView.stopAnimating()
            
            if country != nil {
                // Valid city & country pair
                UserDefaults.setBool(value: true, forKey: UserDefaultsKeys.kIsCitySelected)
                UserDefaults.setObject(object: inputCity, forKey: UserDefaultsKeys.kCity)
                self.navigateToWeatherView()
            }
            else {
                // location not found
                self.labelErrorMessage.isHidden = false
                self.labelErrorMessage.text = self.kErrorMessageInvalidCity
            }
            
        }
        
    }

    private func navigateToWeatherView() {
        self.performSegue(withIdentifier: kSegueWeather, sender: self)
    }
    
}


