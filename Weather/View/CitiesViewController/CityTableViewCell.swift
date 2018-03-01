//
//  CityTableViewCell.swift
//  Weather
//
//  Created by Bodya on 28.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityView: CityView!
    
    func setupCell(cityWeather : CityWeather) {
        self.cityView.setupWith(cityViewModel: CityViewModel(cityWeather: cityWeather))
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
