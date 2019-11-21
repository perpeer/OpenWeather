//
//  Protocol.swift
//  WeatherPlus
//
//  Created by Ekrem TAŞKIRAN on 15.09.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import UIKit

protocol ContentOffSetSettable {
  func lastContentOffset(y: CGFloat)
}

protocol AlphaChangeable {
  func change(alpha: CGFloat)
}

