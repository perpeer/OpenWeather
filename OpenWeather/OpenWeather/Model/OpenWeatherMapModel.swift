//
//  OpenWeatherMapModel.swift
//  OpenWeather
//
//  Created by Ekrem TAŞKIRAN on 21.11.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import Foundation

extension OpenWeatherMapModel {
  static func degreeAccordingToType(value: Double) -> String {
    switch Constants.DegreeTypeValue {
    case .Celsius: return "\(String(format: "%.1f", value))\(Constants.DegreeType.Celsius.rawValue)"
    case .Fahrenheit: return "\(String(format: "%.1f", (value * 1.8) + 32))\(Constants.DegreeType.Fahrenheit.rawValue)"
    }
  }
}

struct OpenWeatherMapModel: Codable {
  let city: City?
  let cod: String
  let message: Double
  let cnt: Int?
  let list: [DailyWeather]?
}

struct City: Codable {
  let id: Int
  let name: String
  let coord: Coordinate
  let country: String
  let population: Int
  let timezone: Int
}

struct Coordinate: Codable {
  let longitude: Double
  let latitude: Double
  
  enum CodingKeys: String, CodingKey {
    case longitude = "lon"
    case latitude = "lat"
  }
}

struct DailyWeather: Codable {
  let dt: Int
  let sunrise: Int
  let sunset: Int
  let temp: Temp
  let pressure: Int
  let humidity: Int
  let weather: [Weather]
  let speed: Double
  let deg: Int
  let clouds: Int
}

struct Temp: Codable {
  let day: Double
  let min: Double
  let max: Double
  let night: Double
  let eve: Double
  let morn: Double
}

struct Weather: Codable {
  let id: Int
  let main: String
  let description: String
  let icon: String
}
