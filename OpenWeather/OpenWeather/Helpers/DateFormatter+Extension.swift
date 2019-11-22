//
//  DateFormatter+Extension.swift
//  OpenWeather
//
//  Created by Ekrem TAŞKIRAN on 22.11.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import Foundation

extension DateFormatter {
  static func dayNameFrom(timeIntervalSince1970 date: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: date)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: date)
  }
}
