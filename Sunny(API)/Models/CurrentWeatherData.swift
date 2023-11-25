//
//  CurrentWeatherData.swift
//  Sunny(API)
//
//  Created by Александр Андреев on 25.11.2023.
//

import Foundation

struct CurrentWeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    
    //enum создан для того чтобы изменить название feels_like на feelsLike
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable{
    let id: Int
}
