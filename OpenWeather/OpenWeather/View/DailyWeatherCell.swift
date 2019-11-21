//
//  DailyWeatherCell.swift
//  OpenWeather
//
//  Created by Ekrem TAŞKIRAN on 21.11.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import UIKit

class DailyWeatherCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .red
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
