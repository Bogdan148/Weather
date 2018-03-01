//
//  CityView.swift
//  Weather
//
//  Created by Bodya on 28.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

import UIKit

class CityView: UIView {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var minMaxTemperature: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var flagImageView: UIImageView!

    func setupWith(cityViewModel : CityViewModel) {
    
        self.cityLabel.text = NSLocalizedString(cityViewModel.cityWeather.city.name, comment: "")
        self.countryLabel.text = cityViewModel.cityWeather.city.country
        let minTemp = Int(cityViewModel.cityWeather.weather[0].main.tempMin)
        let maxTemp = Int(cityViewModel.cityWeather.weather[0].main.tempMax)
        self.descriptionLabel.text = cityViewModel.cityWeather.weather[0].weatherInfo.description
        self.minMaxTemperature.text = "\(minTemp)°C - \(maxTemp)°C"
        cityViewModel.loadFlagImage {
            self.flagImageView.image = cityViewModel.flagImage
        }
        cityViewModel.loadWeatherImage {
            self.imageView.image = cityViewModel.weatherImage
        }

    }
    

}
