//
//  MainView.swift
//  Sunny(API)
//
//  Created by Александр Андреев on 22.11.2023.
//

import UIKit

class MainView: UIView {
    
    private let backround = UIImageView(image: UIImage(named: Resources.Images.backgroundImage))
    
    public let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Ufa"
        label.textColor = UIColor(named: "infoColor")
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        label.textAlignment = .right
        label.contentMode = .left
        return label
    }()
    
    public let searchButton: UIButton = {
        let button = UIButton()
        
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        button.tintColor = UIColor(named: "infoColor")
        return button
    }()
    
    private let citySearchSV: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 8
        sv.alignment = .fill
        sv.distribution = .fill
        sv.contentMode = .scaleToFill
        sv.backgroundColor = .clear
        return sv
    }()
    
    public let weatherIcon: UIImageView = {
        let im = UIImageView(image: UIImage(systemName: "cloud.rain.fill"))
        im.tintColor = UIColor(named: "infoColor")
        return im
    }()
    
    private let informationAboutWeatherSV: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 20
        sv.axis = .vertical
        sv.alignment = .center
        sv.distribution = .equalSpacing
        sv.contentMode = .scaleToFill
        sv.backgroundColor = .clear
        return sv
    }()
    
    public let currentTemperature: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.textColor = UIColor(named: "infoColor")
        label.font = UIFont.systemFont(ofSize: 70, weight: .black)
        label.contentMode = .left
        return label
    }()
    
    public let typeOfTemperature: UILabel = {
        let label = UILabel()
        label.text = "°C"
        label.textColor = UIColor(named: "infoColor")
        label.font = UIFont.systemFont(ofSize: 70)
        label.contentMode = .left
        return label
    }()
    
    private let temperatureSV: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 8
        sv.alignment = .fill
        sv.distribution = .fill
        sv.axis = .horizontal
        return sv
    }()
    
    private let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "Feels like"
        label.textColor = UIColor(named: "infoColor")
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.contentMode = .left
        return label
    }()
    
    public let feelsLikeTemperature: UILabel = {
        let label = UILabel()
        label.text = "23 °C"
        label.textColor = UIColor(named: "infoColor")
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.contentMode = .left
        return label
    }()
    
    private let feelsSV: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 10
        sv.alignment = .fill
        sv.distribution = .fill
        sv.axis = .horizontal
        return sv
    }()
    
    private let globalTempSV: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 0
        sv.alignment = .trailing
        sv.distribution = .fill
        sv.axis = .vertical
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addingSubviews()
        setupConstraints()
    }
    
    private func addingSubviews() {
        addSubview(backround)
        addSubview(citySearchSV)
        addSubview(informationAboutWeatherSV)
        
        //subviews for citySearchSV
        citySearchSV.addArrangedSubview(cityLabel)
        citySearchSV.addArrangedSubview(searchButton)
        
        //subviews for informationAboutWeatherSV
        informationAboutWeatherSV.addArrangedSubview(weatherIcon)
        informationAboutWeatherSV.addArrangedSubview(globalTempSV)
        
        //subviews for globalTempSV
        globalTempSV.addArrangedSubview(temperatureSV)
        globalTempSV.addArrangedSubview(feelsSV)
        
        //subviews for temperatureSV
        temperatureSV.addArrangedSubview(currentTemperature)
        temperatureSV.addArrangedSubview(typeOfTemperature)
        
        //subviews for feelsSV
        feelsSV.addArrangedSubview(feelsLikeLabel)
        feelsSV.addArrangedSubview(feelsLikeTemperature)
        
        
    }
    
    private func setupConstraints() {
        backround.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        citySearchSV.snp.makeConstraints { make in
            make.width.equalTo(83)
            make.height.equalTo(32)
            make.right.equalToSuperview().inset(16.33)
            make.bottom.equalToSuperview().inset(54)
        }
        
        cityLabel.snp.makeConstraints { make in
            make.width.equalTo(44)
            make.height.equalTo(31)
        }
        
        searchButton.snp.makeConstraints { make in
            make.height.width.equalTo(31)
        }
        
        informationAboutWeatherSV.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
            
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.width.height.equalTo(170)
        }
        
       
        
        
        
        
    }

}
