//
//  DetailCellModel.swift
//  Weather
//
//  Created by Bodya on 28.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

import UIKit

class DetailCellModel: NSObject {
    let weather : Weather
    var weatherImage : UIImage?
    
    init(weather : Weather) {
        self.weather = weather
        super.init()
        
    }
    
    func loadWeatherImage(complition : @escaping () -> Void) -> Void {
        DispatchQueue.global().async {
            let weatherImageUrl = "http://openweathermap.org/img/w/\(self.weather.weatherInfo.icon).png"
            self.weatherImage = UIImage.imageFromUrl(urlString: weatherImageUrl)
            DispatchQueue.main.async {
                complition()
            }
        }
    }
}
