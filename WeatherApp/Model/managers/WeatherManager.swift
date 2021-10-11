//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Alex Cruz on 2021-10-09.
//

import Foundation
import Alamofire

struct WeatherManager{
    
    let API_KEY = "5a69c30083a9a8b82d60e3a67100db20"
    
    func fetchWeather(byCity city: String,  completion: @escaping (Result<WeatherData, Error>) -> Void){
        
       let query = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? city
        let path = "https://api.openweathermap.org/data/2.5/weather?q=%@&appid=%@&units=metric"
       let urlString = String(format: path, query, API_KEY)
       // handleRequest(urlString: urlString, completion: completion)*/
        AF.request(urlString).responseDecodable(of: WeatherData.self, queue: .main, decoder: JSONDecoder()) { (response) in
            switch response.result {
            case .success(let weatherData):
                completion(.success(weatherData))
                
               /* let model = weatherData.model
                self.cacheManager.cacheCity(cityName: model.countryName)
                completion(.success(model))*/
            case .failure(let error):
                completion(.failure(error))
               /* if let err = self.getWeatherError(error: error, data: response.data) {
                    completion(.failure(err))
                } else {
                    completion(.failure(error))
                }*/
            }
        }
        
    }
}
