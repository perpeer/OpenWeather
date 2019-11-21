//
//  GooglePlaceChangable.swift
//  OpenWeather
//
//  Created by Ekrem TAŞKIRAN on 21.11.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import GooglePlaces

protocol GooglePlaceChangable {
  func change(place: GMSPlace)
}
