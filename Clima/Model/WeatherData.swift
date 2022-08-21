//
//  WeatherData.swift
//  Clima
//
//  Created by ddd on 20.08.2022.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main:Decodable {
    let temp:Double
}

struct Weather:Decodable {
    let id: Int
}
