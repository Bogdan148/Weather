//
//  CellModel.swift
//  Weather
//
//  Created by Bodya on 28.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

import UIKit

class CityViewModel: NSObject {

    let cityWeather : CityWeather
    var flagImage : UIImage?
    var weatherImage : UIImage?
    
    init(cityWeather : CityWeather) {
        self.cityWeather = cityWeather
        super.init()
        
    }
    
    func loadFlagImage(complition : @escaping () -> Void) -> Void {
        DispatchQueue.global().async {
            let flagUrl = "http://www.countryflags.io/\(self.cityWeather.city.country!)/flat/64.png"
            self.flagImage = UIImage.imageFromUrl(urlString: flagUrl)
            DispatchQueue.main.async {
                complition()
            }
            
        }
    }
    
    func loadWeatherImage(complition : @escaping () -> Void) -> Void {
        DispatchQueue.global().async {
            let weatherImageUrl = "http://openweathermap.org/img/w/\(self.cityWeather.weather[0].weatherInfo.icon).png"
            self.weatherImage = UIImage.imageFromUrl(urlString: weatherImageUrl)
            DispatchQueue.main.async {
                complition()
            }
        }
    }
}


