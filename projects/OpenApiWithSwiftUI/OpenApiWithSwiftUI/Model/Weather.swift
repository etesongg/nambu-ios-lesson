//
//  Weather.swift
//  WeatherApp
//
//  Created by wizard on 5/16/24.
//

import Foundation

struct Weather:Codable {
    let main:String
    let description:String
    let icon:String
}

struct Main:Codable {
    let temp: Double
    let humidity: Int
}

struct Result:Codable {
    let weather:[Weather]
    let main: Main
}

struct Forecast: Codable, Identifiable {
    let id: Int
    let main: Main
    let weather: [Weather]
    let date: String
    enum CodingKeys: String, CodingKey {
        case id = "dt"
        case main
        case weather
        case date = "dt_txt"
    }
}

struct Root: Codable {
    let list:[Forecast]
}



