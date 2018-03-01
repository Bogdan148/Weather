//
//  WeatherManager.swift
//  Weather
//
//  Created by Bodya on 27.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

import UIKit

class WeatherManager {

    let lastPositionKey = "lastPosition"
    let citiesKey = "CitiesKey"
    
    func downloadWeather(lon : String, lat : String, complition : @escaping (CityWeather) -> Void) {
        APIService().getWeather(lon: lon, lat: lat) { (data) in
            let cityWeather = self.serializeData(data: data)
            self.cashedWeather(key: self.lastPositionKey, data: data)
            complition(cityWeather)
        }
    }
    
    func downloadWeather(cityName : String, complition : @escaping (CityWeather) -> Void) {
        APIService().getWeather(cityName : cityName) { (data) in
            let cityWeather = self.serializeData(data: data)
            complition(cityWeather)
        }
    }
    
    func downloadWeather(cities : [String], complition : @escaping ([CityWeather]) -> Void) {
        let dispatchGroup = DispatchGroup()
        var citiesWeather = Array<CityWeather>()
        var cashedCitiesWeather = Array<Data>()
        
        for city in cities {
            dispatchGroup.enter()
            APIService().getWeather(cityName: city, complition: { (data) in
                let cityWeather = self.serializeData(data: data)
                cashedCitiesWeather.append(data)
                citiesWeather.append(cityWeather)
                dispatchGroup.leave()
            })
        }
        dispatchGroup.notify(queue: .main) {
            UserDefaults.standard.set(cashedCitiesWeather, forKey: self.citiesKey)
            complition(citiesWeather)
        }
    }
    
    func getCashedWeatherForCities() -> ([CityWeather]) {
        var cityWeathers = Array<CityWeather>()
        if let array = UserDefaults.standard.array(forKey: citiesKey) {
            for data in array {
                let cityWeather = serializeData(data: data as! Data)
                cityWeathers.append(cityWeather)
            }
        }
        return cityWeathers
    }
    
    func getCashedWeatherFromLastPosition() -> (CityWeather?) {
        return getCashedWeather(key: lastPositionKey)
    }
    
    private func getCashedWeather(key : String) -> (CityWeather?) {
        if let data = UserDefaults.standard.data(forKey: makeKey(key: key)) {
            return serializeData(data: data)
        } else {
            return nil
        }
    }
    
    private func cashedWeather(key : String, data : Data) {
        UserDefaults.standard.set(data, forKey: makeKey(key: key))
    }
    
    private func makeKey(key: String) -> String {
        print("key Weather.\(key)")
        return "Weather.\(key)"
    }
    
    private func serializeData(data : Data) -> CityWeather {
        let json : NSDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
        let cityWeather = CityWeather(dictionary: json)
        return cityWeather
    }
}
