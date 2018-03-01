//
//  CitiesViewController.swift
//  Weather
//
//  Created by Bodya on 26.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView()
    var dataSource : [CityWeather]! {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    let cities = ["London","Moscow","Baku","Kiev","Riga","Tokyo","Rome","Paris","Brasilia","Ottawa","Lisbon","Dublin","Budapest","Berlin","Brussels","Yerevan","Tbilisi","Jakarta","Bangkok","Bern","Tunis","Ankara","Stockholm","Washington","Doha","Cairo"]
    
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
            tableView.refreshControl = refreshControl
        } else {
            tableView .addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        if Connectivity.isConnectedToInternet == false {
            self.dataSource  = WeatherManager().getCashedWeatherForCities()
        } else {
            WeatherManager().downloadWeather(cities: cities) { (citiesWeather) in
                self.dataSource = citiesWeather
            }
        }
    }
    
    @objc private func refresh() {
        if Connectivity.isConnectedToInternet == true {
            WeatherManager().downloadWeather(cities: cities) { (citiesWeather) in
                self.dataSource = citiesWeather
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let dataArray = dataSource {
            return dataArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as! CityTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! CityTableViewCell
        cell.setupCell(cityWeather: dataSource![indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.cityWeather = dataSource[indexPath.row]
        detailVC.isUpdateble = false
        self.navigationController?.pushViewController(detailVC, animated:true)
    }
    

    

 
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
