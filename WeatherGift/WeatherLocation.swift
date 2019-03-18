//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Daniel Cizmarik on 3/17/19.
//  Copyright © 2019 Daniel Cizmarik. All rights reserved.
//

import Foundation
import Alamofire

class WeatherLocation {
    var name = ""
    var coordinates = ""
    
    func getWeather() {
        let weatherURL = urlBase + urlAPIKey + coordinates
        print(weatherURL)
        
        Alamofire.request(weatherURL).responseJSON { response in
            print(response)
            
        }
    }
}
