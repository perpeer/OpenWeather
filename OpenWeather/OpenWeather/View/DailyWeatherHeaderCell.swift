//
//  DailyWeatherHeaderCell.swift
//  OpenWeather
//
//  Created by Ekrem TAŞKIRAN on 21.11.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import UIKit

class DailyWeatherHeaderCell: UICollectionViewCell {
  
  var cityName: String? {
    didSet {
      guard let cityName = cityName else { return }
      cityNameLabel.text = "\(cityName)"
    }
  }
  
  var weather: DailyWeather? {
    didSet {
      if let weather = self.weather {
        tempLabel.text = OpenWeatherMapModel.degreeAccordingToType(value: weather.temp.day)
        humidityLabel.text = "%\(weather.humidity)"
        guard let status = weather.weather.first else { return }
        weatherStatusImage.image = UIImage(named: status.icon)
        weatherStatusLabel.text = "\(status.main)"
      }
    }
  }
  
  let cityNameLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 48))
  let weatherStatusImage = UIImageView(image: UIImage(), contentMode: .scaleAspectFill)
  let weatherStatusLabel = UILabel(text: "", font: .systemFont(ofSize: 24))
  let tempLabel = UILabel(text: "", font: .systemFont(ofSize: 32))
  let humidityLabel = UILabel(text: "", font: .systemFont(ofSize: 32))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.rgb(red: 41, green: 128, blue: 185)
    setupLayout()
  }
  
  fileprivate func setupLayout() {
    let weatherStatusContainer = UIStackView(arrangedSubviews: [
      weatherStatusImage, weatherStatusLabel
    ], axis: .vertical, alignment: .center)
    
    let topContainer = UIStackView(arrangedSubviews: [
      cityNameLabel, weatherStatusContainer
    ])
    topContainer.distribution = .fillProportionally
    
    addSubview(topContainer)
    topContainer.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 200))
    
    let bottomStackView = UIStackView(arrangedSubviews: [
      tempLabel, humidityLabel
    ])
    tempLabel.textAlignment = .center
    humidityLabel.textAlignment = .center
    bottomStackView.distribution = .fillEqually
    
    addSubview(bottomStackView)
    bottomStackView.anchor(top: topContainer.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
