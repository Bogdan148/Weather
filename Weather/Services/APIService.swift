//
//  APIService.swift
//  Weather
//
//  Created by Bodya on 26.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

import Foundation


class APIService {
    
    var urlComponents = URLComponents(string: "http://api.openweathermap.org/data/2.5/forecast")
    let configurate = URLSessionConfiguration.default
    
    private func getWether(parameters : [URLQueryItem], complition : @escaping (_ data : Data) -> Void) -> Void {
        let session = URLSession(configuration: configurate)
        
        urlComponents?.queryItems = [URLQueryItem(name: "APPID", value: "052738d3b190b2f1abb7f9c5ce595026"),
                                     URLQueryItem(name: "mode", value: "JSON"),
                                     URLQueryItem(name: "units", value: "metric"),
                                     URLQueryItem(name: "lang",value: Lenguague().apiKey())] + parameters
        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest) { (data : Data!, response : URLResponse!, error : Error!) in
            if (data) != nil {
                complition(data)
            }
        }
        task.resume()
    }
    
    func getWeather(lon : String, lat : String, complition : @escaping (_ data : Data) -> Void) -> Void {
        
        let params = [URLQueryItem(name: "lat", value: lat),
                      URLQueryItem(name: "lon", value: lon)]
        
       getWether(parameters: params, complition: complition)
    }
    
    func getWeather(cityName : String, complition : @escaping (_ data : Data) -> Void) -> Void {
        let params = [URLQueryItem(name: "q", value: cityName)]
        
        getWether(parameters: params, complition: complition)
    }
}

