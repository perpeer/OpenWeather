//
//  DailyWeatherCell.swift
//  OpenWeather
//
//  Created by Ekrem TAŞKIRAN on 21.11.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import UIKit

class DailyWeatherCell: UICollectionViewCell {
  
  var weather: DailyWeather? {
    didSet {
      if let weather = self.weather {
        dayNameLabel.text = DateFormatter.dayNameFrom(timeIntervalSince1970: TimeInterval(weather.dt))
        dayTemp.text = OpenWeatherMapModel.degreeAccordingToType(value: weather.temp.day)
        nightTemp.text = OpenWeatherMapModel.degreeAccordingToType(value: weather.temp.night)
        guard let status = weather.weather.first else { return }
        weatherStatusImage.image = UIImage(named: status.icon)
        weatherStatusLabel.text = "\(status.main)"
      }
    }
  }
  
  let dayNameLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 24))
  let weatherStatusImage = UIImageView(image: #imageLiteral(resourceName: "01d"), contentMode: .scaleAspectFit)
  let weatherStatusLabel = UILabel(text: "", font: .systemFont(ofSize: 20))
  let dayImage = UIImageView(image: #imageLiteral(resourceName: "01d"), contentMode: .scaleAspectFit)
  let dayTemp = UILabel(text: "", font: .systemFont(ofSize: 20))
  let nightImage = UIImageView(image: #imageLiteral(resourceName: "01n"), contentMode: .scaleAspectFit)
  let nightTemp = UILabel(text: "", font: .systemFont(ofSize: 20))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.rgb(red: 52, green: 152, blue: 219)
    setupLayout()
  }
  
  fileprivate func setupLayout() {
    let dayStackView = UIStackView(arrangedSubviews: [
      dayImage, dayTemp
    ], axis: .vertical, alignment: .center)
    
    let nightStackView = UIStackView(arrangedSubviews: [
      nightImage, nightTemp
    ], axis: .vertical, alignment: .center)
    
    let weatherContainer = UIStackView(arrangedSubviews: [
      weatherStatusImage, weatherStatusLabel
    ], axis: .vertical, alignment: .center)
    
    addSubview(dayNameLabel)
    dayNameLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 8, left: 8, bottom: 8, right: 8), size: .init(width: 150, height: 0))
    
    let containerStackView = UIStackView(arrangedSubviews: [
      weatherContainer, dayStackView, nightStackView
    ])
    containerStackView.distribution = .fillEqually
    containerStackView.alignment = .center
    
    addSubview(containerStackView)
    containerStackView.anchor(top: topAnchor, leading: dayNameLabel.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 8))
    containerStackView.alignment = .center
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
