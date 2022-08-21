//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController {
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var textFieldSearch: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: TODO что будет если не вызывать это?
        textFieldSearch.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestLocation()
    }
}
//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        print(textFieldSearch.text!)
        textFieldSearch.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textFieldSearch.text!)
        textFieldSearch.endEditing(true)
        return true
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("ask")
        if textFieldSearch.text == "" {
            textFieldSearch.placeholder = "Type something"
            return false
        }
        else {
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = textFieldSearch.text {
            weatherManager.fetchWeather(city: city)
            
        } else {
            
        }
        textFieldSearch.text = ""
    }
}
//MARK: - WheatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    // MARK: TODO try long net request how do returningImage and delegate work??
    func didUpdateWeather(_ weatherManager:WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.temperatureLabel.text = weather.temperatureString
        }
            // MARK: TODO получить здесь ошибку чторабота с лабел только с онсовного потока
    }
    
    func didFailWithError(_ weatherManager:WeatherManager, error: Error) {
        print(error)
    }
}

//MARK: - location manager delegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("new location")
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat)
            print(lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError \(error)"   )
    }
    
}
