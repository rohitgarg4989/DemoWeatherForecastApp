//
//  WeatherInfoViewController.swift
//  DemoWeatherApp
//
//  Created by Rohit Garg on 1/5/19.
//  Copyright © 2019 Rohit Garg. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureMinLabel: UILabel!
    @IBOutlet weak var temperatureMaxLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var forecastTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    // MARK: - View Model
    
    var viewModel: WeatherInfoViewModel? {
        didSet {
            
            self.locationLabel.text = viewModel?.location
            
            viewModel?.errorMessage.observe { (value) in
                if value != nil {
                    self.activityIndicatorView.stopAnimating()
                    self.showAlert(withMessage: value!)
                }
            }
            
            viewModel?.weatherInfo.observe({ (value) in
                if value != nil {
                    self.updateWeatherView(value!)
                }
            })
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        forecastTableView.separatorInset = UIEdgeInsets.zero
        forecastTableView.tableFooterView = UIView()

        setupViewModel()
        activityIndicatorView.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Actions
    
    @IBAction func btnChangeCity(_ sender: UIButton) {
        UserDefaults.setBool(value: false, forKey: UserDefaultsKeys.kIsCitySelected)
        sharedAppDelegate.setRootViewController()
    }
    
    // MARK: - View Methods
    
    private func setupViewModel() {
        viewModel = WeatherInfoViewModel()
        viewModel?.requestWeatherInfo()
    }
    
    private func updateWeatherView(_ weather: Weather) {
        
        self.activityIndicatorView.stopAnimating()
        self.weatherView.isHidden = false
        
        self.temperatureLabel.text = weather.temperature?.degrees
        if let tempMin = weather.temperatureMin?.degrees {
            self.temperatureMinLabel.text = "Min Temp :  \(tempMin)"
        }
        if let tempMax = weather.temperatureMax?.degrees {
            self.temperatureMaxLabel.text = "Max Temp :  \(tempMax)"
        }
        
        self.descriptionLabel.text = weather.description?.capitalized
        self.dateLabel.text = "\(weather.date ?? ""), \(weather.time ?? "")"
        
        forecastTableView.reloadData()
    }
    
}

extension WeatherInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let forecastData = viewModel?.weatherInfo.value?.forecastData else { return 0 }
        return forecastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherForecastTableViewCell.reuseIdentifier, for: indexPath) as? WeatherForecastTableViewCell else { fatalError("Unexpected Table View Cell") }
        
        if let forecastData = viewModel?.weatherInfo.value?.forecastData {
            cell.configureWeatherForecast(forecastData[indexPath.row])
        }

        return cell
    }
    
}
