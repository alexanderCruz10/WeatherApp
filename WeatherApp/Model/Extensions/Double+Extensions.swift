//
//  Double+Extensions.swift
//  WeatherApp
//
//  Created by Alex Cruz on 2021-10-10.
//

import Foundation

extension Double{
    
    func toString() -> String{
        return String(format: "%.1f", self)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
}
