//
//  Constants.swift
//  weatherApp
//
//  Created by Jiashan Wu on 4/10/17.
//  Copyright © 2017 Jiashan Wu. All rights reserved.
//

import Foundation

// BASE
let BASE_URL = "http://api.openweathermap.org/data/2.5/"
let LAT = "lat="
let LON = "&lon="
let API_ID = "&appid="
let API_KEY = "a56a0a63450530cd55d0394e74e75312"

//let currentLat = Location.sharedInstance.latitude!
//let currentLong = Location.sharedInstance.longitude!

/*
    CURRENT WEATHER
    ex: http://api.openweathermap.org/data/2.5/weather?lat=-50&lon=123&appid=a56a0a63450530cd55d0394e74e75312
 */

let WEATHER = "weather?"
let CURRENT_WEATHER_URL = "\(BASE_URL)\(WEATHER)\(LAT)\(Location.sharedInstance.latitude!)\(LON)\(Location.sharedInstance.longitude!)\(API_ID)\(API_KEY)"


/*
    FORECAST
    ex: http://api.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10&appid=a56a0a63450530cd55d0394e74e75312
*/

let FORECAST = "forecast/daily?"
let TEN_DAYS = "&cnt=10"

let FORECAST_URL = "\(BASE_URL)\(FORECAST)\(LAT)\(Location.sharedInstance.latitude!)\(LON)\(Location.sharedInstance.longitude!)\(TEN_DAYS)\(API_ID)\(API_KEY)"


// FOR DOWNLOAD DATA FUNC
typealias downloadComplete = (Bool) -> ()
