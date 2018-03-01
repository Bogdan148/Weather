//
//  ViewController.swift
//  Weather
//
//  Created by Bodya on 26.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class DetailViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource {
 
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cityView: CityView!
    @IBOutlet weak var weatherTableView: UITableView!
    private let refreshControl = UIRefreshControl()
    var isUpdateble = true
    private let activityIndicator = UIActivityIndicatorView()
    var locationManager = CLLocationManager()
    
    var cityWeather : CityWeather! {
        didSet {
            DispatchQueue.main.async {
                self.weatherTableView.reloadData()
                self.cityView.setupWith(cityViewModel: CityViewModel(cityWeather: self.cityWeather))
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
                    self.setMapCoordinat(coordinations: self.cityWeather.city.coordinate)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = view.center
        let transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.transform = transform;
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        if #available(iOS 10, *) {
            weatherTableView.refreshControl = refreshControl
        } else {
            weatherTableView .addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
      
        if cityWeather == nil {
            if Connectivity.isConnectedToInternet == false {
                if let cityWeather = WeatherManager().getCashedWeatherFromLastPosition() {
                    self.cityWeather = cityWeather
                    }
            } else {
                locationManager.startUpdatingLocation()
            }
        }
        
    }
    
    @objc private func refresh() {
        if isUpdateble == true {
            if Connectivity.isConnectedToInternet == true {
                locationManager.startUpdatingLocation()
            }
        } else {
            self.refreshControl.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cityWeather = cityWeather {
            return cityWeather.weather.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! DetailTableViewCell
        let detailCellModel = DetailCellModel(weather: self.cityWeather.weather[indexPath.row])
        tableViewCell.setupWith(detailCellModel: detailCellModel)
        
        return tableViewCell
    }
  

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        locationManager.stopUpdatingLocation()
        
        let location = locations[0]
        let coordinations = CLLocationCoordinate2D(latitude: location.coordinate.latitude,longitude: location.coordinate.longitude)
        self.setMapCoordinat(coordinations: coordinations)

        WeatherManager().downloadWeather(lon: String(format:"%f",coordinations.longitude),
                                         lat: String(format:"%f",coordinations.latitude)) { (cityWeather) in
                                            self.cityWeather = cityWeather
        }
      
    }
    
    func setMapCoordinat(coordinations : CLLocationCoordinate2D) {
        let span = MKCoordinateSpanMake(0.35,0.35)
        let region = MKCoordinateRegion(center: coordinations, span: span)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinations
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
    }


}

