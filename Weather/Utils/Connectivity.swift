//
//  Connectivity.swift
//  Weather
//
//  Created by Bodya on 28.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet : Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

