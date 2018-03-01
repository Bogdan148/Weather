//
//  Extensions.swift
//  Weather
//
//  Created by Bodya on 28.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

import Foundation
import UIKit


extension Date {
    
    
    
    func stringFormate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss"
        dateFormatter.locale = Locale(identifier: Lenguague().dataKey())
        return dateFormatter.string(from: self)
    }
}

extension UIImage {

    class func imageFromUrl(urlString : String) -> (UIImage?) {
        let url = URL(string: urlString)
        if let data = try? Data(contentsOf: url!) {
            return UIImage(data: data)
        }
            return nil
    }
}
