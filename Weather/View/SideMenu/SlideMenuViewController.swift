//
//  SlideMenuViewController.swift
//  Weather
//
//  Created by Bodya on 01.03.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

import UIKit

class SlideMenuViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let pickerViewDataSource = ["Русский","English","Україньска"]
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return pickerViewDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewDataSource[row]
    }

    func keyLenguague() -> String {
        return ["ru","en","uk"][pickerView.selectedRow(inComponent: 0)]
    }
    
    @IBAction func applyLenguague(_ sender: Any) {
        UserDefaults.standard.set([keyLenguague()], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        let controller = UIAlertController.init(title: nil, message: NSLocalizedString("lenguagueAlert", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
        controller.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func sharing(_ sender: Any) {
        
        if let cityWeather  = WeatherManager().getCashedWeatherFromLastPosition() {
            let cityName = NSLocalizedString(cityWeather.city.name!, comment: "")
            let temp = Int(cityWeather.weather[0].main.temp)
            let string = String(format:NSLocalizedString("In %@ temperature is %d°C", comment: ""),cityName,temp)
            let activityVC = UIActivityViewController(activityItems: [string], applicationActivities: [])
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        }
}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
