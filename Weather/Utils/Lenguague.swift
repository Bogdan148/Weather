//
//  Lenguague.swift
//  Weather
//
//  Created by Bodya on 01.03.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

import Foundation

class Lenguague {
    let key = Locale.preferredLanguages.first
    let keysForApi = ["uk":"ua","en":"en","ru":"ru"]
    let keysForFormatter = ["uk":"uk_UK","en":"en_US","ru":"ru_RU"]
    
    func apiKey () -> String {
        return keysForApi[key!]!
    }
    func dataKey () -> String {
        return keysForFormatter[key!]!
    }
}
