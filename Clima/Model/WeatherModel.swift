//
//  WeatherModel.swift
//  Clima
//
//  Created by ddd on 20.08.2022.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 800:
            return "sun"
        case 801...804:
            return "cloud"
        default:
            return "Error: unknown weather ID"
        }
    }
}
