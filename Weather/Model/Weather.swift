//
//  Weather.swift
//  Weather
//
//  Created by Bodya on 27.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

import UIKit
import CoreLocation

struct Main {
    let temp : Double
    let tempMin : Double
    let tempMax : Double
    let plessure : Double
    let seaLevel : Double
    let grndLevel : Double
    let humidity : Double
    let tempKf : Double
}

struct WeatherInfo {
    let main : String
    let description : String
    let icon : String
}

struct Clouds {
    let all : Double!
}

struct Wind {
    let speed : Double
    let deg : Double
}

struct Snow {
    let snow : Double!
}

struct Rain {
    let rain : Double!
}

struct Sys {
    let sys : String
}

class Weather: NSObject {

    var date : Date!
    var main : Main!
    var weatherInfo : WeatherInfo!
    var clouds : Clouds!
    var wind : Wind!
    var rain : Rain!
    var snow : Snow!
    var sys : Sys!
    var dateText : String!
    
    init(dictionary : NSDictionary) {
        super.init()
        
        let time = dictionary.object(forKey: "dt") as! Int
        self.date = Date(timeIntervalSince1970:TimeInterval(time))
        self.main = weatherWithDictionary(dictionary: dictionary.object(forKey: "main") as! NSDictionary)
        let weatherInfoArray = dictionary.object(forKey: "weather") as! NSArray
        let weatherInfoDict = weatherInfoArray.firstObject as! NSDictionary
        self.weatherInfo = weatherInfoWithDictionary(dictionary: weatherInfoDict)
        self.clouds = cloudsWithDictionary(dictionary: dictionary.object(forKey: "clouds") as! NSDictionary)
        self.wind = windWithDictionary(dictionary: dictionary.object(forKey: "wind") as! NSDictionary)
        if let dict = dictionary.object(forKey: "rain") as? NSDictionary {
            self.rain = rainWithDictionary(dictionay: dict)
        }
        if let dict = dictionary.object(forKey: "snow") as? NSDictionary {
            self.snow = snowWithDictionary(dictionary: dict)
        }
        self.sys = sysWithDictionary(dictionary: dictionary.object(forKey: "sys") as! NSDictionary)
        self.dateText = dictionary.object(forKey: "dt_txt") as! String
    }

    func weatherWithDictionary(dictionary : NSDictionary) -> Main {
        return Main.init(temp: dictionary.object(forKey: "temp") as! Double,
                         tempMin: dictionary.object(forKey: "temp_min") as! Double,
                         tempMax: dictionary.object(forKey: "temp_max") as! Double,
                         plessure: dictionary.object(forKey: "pressure") as! Double,
                         seaLevel: dictionary.object(forKey: "sea_level") as! Double,
                         grndLevel: dictionary.object(forKey: "grnd_level") as! Double,
                         humidity: dictionary.object(forKey: "humidity") as! Double,
                         tempKf: dictionary.object(forKey: "temp_kf") as! Double)
    }
    
    func weatherInfoWithDictionary(dictionary : NSDictionary) -> WeatherInfo {
        return WeatherInfo.init(main: dictionary.object(forKey: "main") as! String,
                                description: dictionary.object(forKey: "description") as! String,
                                icon: dictionary.object(forKey: "icon") as! String)
    }
    
    func cloudsWithDictionary(dictionary : NSDictionary) -> Clouds {
        return Clouds.init(all: dictionary.object(forKey: "all") as! Double)
    }
    
    func windWithDictionary(dictionary : NSDictionary) -> Wind {
        return Wind.init(speed: (dictionary.object(forKey: "speed") as! Double),
                         deg: dictionary.object(forKey: "deg") as! Double)
    }
    
    func rainWithDictionary(dictionay : NSDictionary) -> Rain {
        return Rain.init(rain: (dictionay.object(forKey: "3h") as? Double));
    }
    
    func snowWithDictionary(dictionary : NSDictionary) -> Snow {
        return Snow.init(snow: (dictionary.object(forKey: "3h") as? Double))
    }
    
    func sysWithDictionary(dictionary : NSDictionary) -> Sys {
        return Sys.init(sys: dictionary.object(forKey: "pod") as! String)
    }
}

class City {
    let cityId : Int!
    let name : String!
    let coordinate : CLLocationCoordinate2D!
    let country : String!
    let population : Int!
    
    init(dictionary : NSDictionary) {
        self.cityId = dictionary.object(forKey: "id") as! Int
        self.name = dictionary.object(forKey: "name") as! String
        self.country = dictionary.object(forKey: "country") as! String
        self.population = dictionary.object(forKey: "population") as! Int
        let coord = dictionary.object(forKey: "coord") as! NSDictionary
        let lat = coord.object(forKey: "lat") as! Double
        let lon = coord.object(forKey: "lon") as! Double
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}

class CityWeather {
    let city : City!
    let weather : [Weather]!
    
    init(dictionary : NSDictionary) {
        city = City(dictionary: dictionary.object(forKey: "city") as! NSDictionary)
        self.weather = NSMutableArray.init() as! [Weather]
        let array = dictionary.object(forKey: "list") as! NSArray
        for dict in array {
            self.weather.append(Weather(dictionary: dict as! NSDictionary))
        }
    }
    
}
