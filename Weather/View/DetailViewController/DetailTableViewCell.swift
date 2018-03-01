//
//  TableViewCell.swift
//  Weather
//
//  Created by Bodya on 28.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionWeather: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var plessureLabel: UILabel!

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cloudinessLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    func setupWith(detailCellModel : DetailCellModel) {
        
        self.dateLabel.text = detailCellModel.weather.date.stringFormate()
        self.descriptionWeather.text = detailCellModel.weather.weatherInfo.description
        let temperature = Int(detailCellModel.weather.main.temp)
        self.temperatureLabel.text = "\(temperature)°C"
        let pressure = Int(detailCellModel.weather.main.plessure)
        self.plessureLabel.text = String(format: NSLocalizedString("Pressure %d hpa", comment: ""), pressure)
        //"Pressure \(pressure) hpa"

        let humidity = Int(detailCellModel.weather.main.humidity)
        self.humidityLabel.text = String(format: NSLocalizedString("Humidity %d %", comment: ""), humidity)
        
        let cloudinnes = Int(detailCellModel.weather.clouds.all)
        self.cloudinessLabel.text = String(format: NSLocalizedString("Cloudiness %d %", comment: ""), cloudinnes)
        
        let speed = detailCellModel.weather.wind.speed
        
        self.windSpeedLabel.text = String(format: NSLocalizedString("Wind %.2f m/s", comment: ""), speed)
        detailCellModel.loadWeatherImage {
            self.weatherImageView.image = detailCellModel.weatherImage
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

