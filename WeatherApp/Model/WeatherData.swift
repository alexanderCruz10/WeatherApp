//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Alex Cruz on 2021-10-09.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    
   /* var model: WeatherModel {
        return WeatherModel(countryName: name,
                            temp: main.temp.toInt(),
                            conditionId: weather.first?.id ?? 0,
                            conditionDescription: weather.first?.description ?? "")
    }*/
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
}
