//
//  ViewController.swift
//  Sunny(API)
//
//  Created by Александр Андреев on 22.11.2023.
//

import UIKit
import SnapKit
import CoreLocation

class ViewController: UIViewController {
    
    //MARK: Properties
    private let mainView = MainView()
    private var weatherIconImageView: UIImageView!
    private var cityLabel: UILabel!
    private var temperatureLabel: UILabel!
    private var feelsLikeTemperatureLabel: UILabel!
    private var searchButton: UIButton!
    
    
    private var networkWeatherManager = NetworkWeatherManager()
    
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configureView()
        setupViews()
//        networkWeatherManager.fetchCurrentWeather(forRequestType: .)
//        networkWeatherManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
            
        }
        
        
    }
}

extension ViewController {
    
}


//MARK: setup MainView
extension ViewController {
    
    
    private func setupViews() {
        weatherIconImageView = mainView.weatherIcon
        cityLabel = mainView.cityLabel
        temperatureLabel = mainView.currentTemperature
        feelsLikeTemperatureLabel = mainView.feelsLikeTemperature
        searchButton = mainView.searchButton
        
        searchButton.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
    }
    
    private func configureView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func searchPressed() {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { city in
            self.networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: city))
        }
    }
    
    
}

extension ViewController: NetworkWeatherManageDelegate {
    func updateInterface(_: NetworkWeatherManager, with currentWeather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = currentWeather.cityName
            self.feelsLikeTemperatureLabel.text = currentWeather.feelsLikeTemperatureString
            self.temperatureLabel.text = currentWeather.temperatureString
            self.weatherIconImageView.image = UIImage(systemName: currentWeather.systemIconNameString)
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkWeatherManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: latitude, longitude: longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
