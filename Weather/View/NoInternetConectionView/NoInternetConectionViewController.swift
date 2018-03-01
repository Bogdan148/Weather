//
//  NoInternetConectionViewController.swift
//  Weather
//
//  Created by Bodya on 01.03.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

import UIKit

class NoInternetConectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func singInAction(_ sender: Any) {
        if Connectivity.isConnectedToInternet == true {
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "enterView")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = controller
        }
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
