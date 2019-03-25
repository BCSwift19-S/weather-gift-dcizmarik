//
//  TimeInterval+format.swift
//  WeatherGift
//
//  Created by Daniel Cizmarik on 3/25/19.
//  Copyright © 2019 Daniel Cizmarik. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    func format(timeZone: String, dateFormatter: DateFormatter) -> String {
        let useableDate = Date(timeIntervalSince1970: self)
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        let dateString = dateFormatter.string(from: useableDate)
        return dateString
    }
    
}
