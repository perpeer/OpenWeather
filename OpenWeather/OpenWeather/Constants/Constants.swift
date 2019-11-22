//
//  Constants.swift
//  OpenWeather
//
//  Created by Ekrem TAŞKIRAN on 21.11.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import Foundation

struct Constants {
  static let GooglePlaceAPIKey = "AIzaSyBHa2dO8r2xC-06zvaGwBFkphCb9kQgvDs"
  static let OpenWeatherAPIKey = "6965e79f1e772ad83f14a636fcf7cbf9"
  // max query count is 18 and default 7
  static let OpenWeatherQueryCount = 7
  static var DegreeTypeValue = DegreeType.Celsius
  
  enum DegreeType: String {
    case Fahrenheit = "°F"
    case Celsius = "°C"
  }
}
