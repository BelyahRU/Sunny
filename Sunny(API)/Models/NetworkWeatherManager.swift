//
//  NetworkWeatherManager.swift
//  Sunny(API)
//
//  Created by Александр Андреев on 23.11.2023.
//

import Foundation
struct NetworkWeatherManager {
    
    public func fetchCurrentWeather(forCity city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(Resources.ApiKeys.weatherApiKey)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
//                let dataString = String(data: data, encoding: .utf8)
//                print(dataString!)
                self.paseJSON(withData: data)
            }
        }
        //вызываем для того чтобы произошел запрос
        task.resume()
    }
    
    
    //распаковка данных
    public func paseJSON(withData data: Data) {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            print(currentWeatherData.main.temp)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
}
