//
//  Service.swift
//  OpenWeather
//
//  Created by Ekrem TAŞKIRAN on 21.11.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import Foundation

class Service {
  static let shared = Service()
  
  func fetchDataFrom(cityName: String, completionHandler: @escaping (OpenWeatherMapModel?, Error?) -> Void) {
    let urlString = "http://api.openweathermap.org/data/2.5/forecast/daily?q=\(cityName)&units=metric&cnt=\(Constants.OpenWeatherQueryCount)&appid=\(Constants.OpenWeatherAPIKey)"
    if let urlStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
      let url = URL(string: urlStr)
      URLSession.shared.dataTask(with: url!) { (data, resp, err) in
        if let err = err {
          print("fetchDataFromUrl failed: ", err)
          return
        }
        if let data = data {
          do {
            let json = try JSONDecoder().decode(OpenWeatherMapModel.self, from: data)
            if json.cod == "200" {
              completionHandler(json, nil)
            } else {
              completionHandler(nil, err)
            }
          } catch let err {
            print(err.localizedDescription)
            completionHandler(nil, err)
          }
        }
      }.resume()
    }
  }
}
