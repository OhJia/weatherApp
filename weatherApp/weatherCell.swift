//
//  weatherCell.swift
//  weatherApp
//
//  Created by Jiashan Wu on 4/10/17.
//  Copyright © 2017 Jiashan Wu. All rights reserved.
//

import UIKit

class weatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var weatherHighLabel: UILabel!    
    @IBOutlet weak var weatherLowLabel: UILabel!

    func configureCell(forecast: Forecast) {
        dayLabel.text = forecast.date
        weatherTypeLabel.text = forecast.weatherType
        weatherHighLabel.text = forecast.weatherHigh
        weatherLowLabel.text = forecast.weatherLow
        weatherImage.image = UIImage(named: forecast.weatherType)
    }

}
