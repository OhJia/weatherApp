//
//  Location.swift
//  weatherApp
//
//  Created by Jiashan Wu on 4/10/17.
//  Copyright © 2017 Jiashan Wu. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
