//
//  ViewController.swift
//  Sunny(API)
//
//  Created by Александр Андреев on 22.11.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let mainView = MainView()
    private var weatherIconImageView: UIImageView!
    private var cityLabel: UILabel!
    private var temperatureLabel: UILabel!
    private var feelsLikeTemperatureLabel: UILabel!
    private var searchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configureView()
        setupViews()
    }
    
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
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert)
    }


}

