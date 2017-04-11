//
//  WeatherVC.swift
//  weatherApp
//
//  Created by Jiashan Wu on 4/10/17.
//  Copyright © 2017 Jiashan Wu. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Location manager stuff
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // only get location when app is open
        locationManager.startMonitoringSignificantLocationChanges()
        
        // TableView Stuff
        tableView.delegate = self
        tableView.dataSource = self

        
        currentWeather = CurrentWeather()
        
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        currentLocation = locations[0]
//        // These can be accessed anywhere in the app
//        Location.sharedInstance.latitude = currentLocation.coordinate.latitude
//        Location.sharedInstance.longitude = currentLocation.coordinate.longitude
//        
//        print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
//    }
//    
//    
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error)
//    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            
            // These can be accessed anywhere in the app
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
            
            // Download from Open Weather Map API: current weather
            currentWeather.downloadWeatherDetails(completed: { (success) in
                if success {
                    // Download from Open Weather Map API: forecast
                    self.downloadForecastDetails(completed: { (success) in
                        if success {
                            self.updateMainUI()
                            self.tableView.reloadData()
                        } else {
                            print("FAILED TO PASS JSON FOR FORECAST")
                        }
                    })
                    
                } else {
                    print("FAILED TO PASS JSON FOR CURRENT WEATHER")
                }
            })
            
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastDetails(completed: @escaping downloadComplete) {
        let forecastWeatherURL = URL(string: FORECAST_URL)
        
        Alamofire.request(forecastWeatherURL!).responseJSON { response in
            let result = response.result
            var success = true
            
            if let dictionary = result.value as? Dictionary<String, AnyObject> {
                if let list = dictionary["list"] as? [Dictionary<String, AnyObject>] {
                    for object in list {
                        let forecast = Forecast(weatherDic: object)
                        self.forecasts.append(forecast)
                        
//                        print("FORECAST GET:")
//                        print("forecast date: \(forecast.date)")
//                        print("forecast weather type: \(forecast.weatherType)")
//                        print("forecast weather high: \(forecast.weatherHigh)")
//                        print("forecast weather low: \(forecast.weatherLow)")
//                        print("--")
                    }
                    self.forecasts.remove(at: 0)
                    print(self.forecasts)
                }
            } else {
                success = false
            }
            
            // MUST HAVE THIS
            completed(success)
        }
    }
    
    /*
        Must implement for TableViewDataSource
     */

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? weatherCell {
            let forecast = self.forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return weatherCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    // If no header, then just 1 section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Optional
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)°"
        locationLabel.text = currentWeather.cityName
        currentWeatherTypeLabel.text = currentWeather.weatherType
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
        //print("--")
        //print("UI current temp: \(currentWeather.currentTemp)")
        //print("UI city name: \(currentWeather.cityName)")
        //print("UI current weather type: \(currentWeather.weatherType)")
        //print("--")
    }
    
    
}

