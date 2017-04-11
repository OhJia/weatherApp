//
//  Forecast.swift
//  weatherApp
//
//  Created by Jiashan Wu on 4/10/17.
//  Copyright © 2017 Jiashan Wu. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _weatherHigh: String!
    var _weatherLow: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var weatherHigh: String {
        if _weatherHigh == nil {
            _weatherHigh = ""
        }
        
        return _weatherHigh
    }
    
    var weatherLow: String {
        if _weatherLow == nil {
            _weatherLow = ""
        }
        
        return _weatherLow
    }
    
    init(weatherDic: Dictionary<String, AnyObject>) {
        if let temp = weatherDic["temp"] as? Dictionary<String, AnyObject> {
            
            // get weather low
            if let min = temp["min"] as? Double {
                let kelvinToFarenheitPreDivision = min * (9/5) - 459.67
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                self._weatherLow = "\(kelvinToFarenheit)"
            }
            
            // get weather high
            if let max = temp["max"] as? Double {
                let kelvinToFarenheitPreDivision = max * (9/5) - 459.67
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                self._weatherHigh = "\(kelvinToFarenheit)"
            }
            
        }
        
        // get weather type
        if let weather = weatherDic["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] {
                self._weatherType = main.capitalized
            }
        }
        
        // get date
        if let date = weatherDic["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: TimeInterval(date))
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfWeek()
        }
        
    } // END OF INIT
    
    
}

extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // Get full name of day
        return dateFormatter.string(from: self)
    }
}
