//
//  CurrentWeather.swift
//  weatherApp
//
//  Created by Jiashan Wu on 4/10/17.
//  Copyright © 2017 Jiashan Wu. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping downloadComplete) {
        // Alamofire download
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)
        
        // This is a closure: need self.
        Alamofire.request(currentWeatherURL!).responseJSON { response in
            let result = response.result
            //print(response)
            var success = true
            if let dictionary = result.value as? Dictionary<String, AnyObject> {
                
                // Set cityName
                if let cityName = dictionary["name"] as? String {
                    self._cityName = cityName.capitalized
                    print("city name: \(self._cityName!)")
                }
                
                // Set weatherType
                if let weather = dictionary["weather"] as? [Dictionary<String, AnyObject>] {
                    if let type = weather[0]["main"] as? String {
                        self._weatherType = type.capitalized
                        print("weather type: \(self._weatherType!)")
                    }
                }
                
                // Set currentTemp
                if let main = dictionary["main"] as? Dictionary<String, Double> {
                    if let temp = main["temp"] {
                        let kelvinToFarenheitPreDivision = temp * (9/5) - 459.67
                        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                        self._currentTemp = kelvinToFarenheit
                        print("current temp: \(self._currentTemp!)")
                    }
                }
            } else {
                success = false
            }
            
            // MUST HAVE THIS
            completed(success)
        }
        
        
        
    }
    
}
