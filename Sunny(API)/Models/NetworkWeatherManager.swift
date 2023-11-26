//
//  NetworkWeatherManager.swift
//  Sunny(API)
//
//  Created by Александр Андреев on 23.11.2023.
//

import Foundation
import CoreLocation

protocol NetworkWeatherManageDelegate:class {
    func updateInterface(_: NetworkWeatherManager, with currentWeather: CurrentWeather)
}

class NetworkWeatherManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    func fetchCurrentWeather(forRequestType requestType:RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(Resources.ApiKeys.weatherApiKey)&units=metric"
            //        performRequest(withURLString: urlString)
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)lon=\(longitude)&appid=\(Resources.ApiKeys.weatherApiKey)&units=metric"
            
        }
        performRequest(withURLString: urlString)
    }
    
    weak var delegate: NetworkWeatherManageDelegate?
    
    
//    public func fetchCurrentWeather(forCity city: String) {
//        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(Resources.ApiKeys.weatherApiKey)&units=metric"
//        performRequest(withURLString: urlString)
//    }
//
//    public func fetchCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
//        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)lon=\(longitude)&appid=\(Resources.ApiKeys.weatherApiKey)&units=metric"
//        performRequest(withURLString: urlString)
//    }
    
    fileprivate func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
//                let dataString = String(data: data, encoding: .utf8)
//                print(dataString!)
                if let currentWeather = self.paseJSON(withData: data) {
                    self.delegate?.updateInterface(self, with: currentWeather)
                }
            }
        }
        //вызываем для того чтобы произошел запрос
        task.resume()
    }
    
    //распаковка данных
    fileprivate func paseJSON(withData data: Data) -> CurrentWeather?{
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else {
                return nil
            }
            return currentWeather
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
        
    }
}
