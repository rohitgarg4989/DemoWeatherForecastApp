//
//  WeatherForecastTableViewCell.swift
//  DemoWeatherApp
//
//  Created by Rohit Garg on 1/6/19.
//  Copyright © 2019 Rohit Garg. All rights reserved.
//

import UIKit

class WeatherForecastTableViewCell: UITableViewCell {

    // MARK: - Type Properties
    
    static let reuseIdentifier = "ForecastCell"
    
    // MARK: - Properties
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var temperatureMinLabel: UILabel!
    @IBOutlet weak var temperatureMaxLabel: UILabel!

    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Configuration
    
    func configureWeatherForecast(_ forecast: WeatherForecast) {
        
        self.dateTimeLabel.text = "\(forecast.date ?? "")"

        if let tempMin = forecast.temperatureMin?.degrees {
            self.temperatureMinLabel.text = "Min:  \(tempMin)"
        }
        if let tempMax = forecast.temperatureMax?.degrees {
            self.temperatureMaxLabel.text = "Max:  \(tempMax)"
        }
        
    }

}
