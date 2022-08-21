//
//  WeatherManager.swift
//  Clima
//
//  Created by ddd on 20.08.2022.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager:WeatherManager, weather: WeatherModel)
    func didFailWithError(_ weatherManager: WeatherManager, error: Error)
}


struct WeatherManager {
    let jsonWeatherAnswer = """
        {
            "coord": {
                "lon": -122.09,
                "lat": 37
            },
            "weather": [{
                "id":201,
                "main": "Clear"
            }],
            "main": {
                "temp": 19.18,
                "pressure": 765
            },
            "name": "Paris"
        
        }
        """
    var delegate: WeatherManagerDelegate?
    let weatherURL = ""
    //try to get error when use http
    
    func fetchWeather(city: String) {
        let urlString = "\(weatherURL)&q=\(city)"
        let dataWeatherAnswer = jsonWeatherAnswer.data(using: .utf8)!
        if let weather = parseJSON(weatherData: dataWeatherAnswer) {
            delegate?.didUpdateWeather(self, weather: weather)
        }
        else {
            print("Error: in getting WeatherModel")
        }
        
        
    }
    
    func performRequest(urlString: String) {
        // MARK: TODO try to change confiquration
        
        guard let url = URL(string: urlString) else {
            print("Error: create URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {
            data, response, error in
            if error != nil {
                print(error!)
                return
            }
            if let safeDate = data {
                let dataString = String(data: safeDate, encoding: .utf8)
            }
            
        }
        task.resume()
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        
        var weatherModel:WeatherModel?
        
        do {
            let decoderWeatherData = try decoder.decode(WeatherData.self, from: weatherData)
            let cityName = decoderWeatherData.name
            let temperature = decoderWeatherData.main.temp
            let conditionalId = decoderWeatherData.weather[0].id
            
            weatherModel = WeatherModel(conditionId: conditionalId, cityName: cityName, temperature: temperature)
            print(weatherModel!.conditionName)
            print(weatherModel!.temperatureString)
        }
        catch {
            delegate?.didFailWithError(self, error: error)
        }
        //performRequest(urlString: urlString)
        return weatherModel
    }
    
    
    
}
