//
//  HomeController.swift
//  OpenWeather
//
//  Created by Ekrem TAŞKIRAN on 21.11.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import UIKit
import GooglePlaces

class HomeController: BaseListController {
  
  private let dailyWeatherCellId = "dailyWeatherCellId"
  private let dailyWeatherHeaderCell = "dailyWeatherHeaderCell"
  
  private var place: GMSPlace? {
    didSet {
      if let cityName = self.place?.name {
        weatherDataFetchWith(cityName: cityName)
      }
    }
  }
  
  private var weather: OpenWeatherMapModel? {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  fileprivate func weatherDataFetchWith(cityName: String) {
    Service.shared.fetchDataFrom(cityName: cityName) { (result, error) in
      if let err = error {
        print("Fetch city weather failed:", err)
        return
      }
      self.weather = result
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(DailyWeatherCell.self, forCellWithReuseIdentifier: dailyWeatherCellId)
    collectionView.register(DailyWeatherHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: dailyWeatherHeaderCell)
    
    weatherDataFetchWith(cityName: "ankara")
    
    setupNavControllerLayout()
  }
  
  fileprivate func setupNavControllerLayout() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleNavRightButton))
  }
  
  @objc func handleNavRightButton() {
    let searchPlaceController = SearchPlaceController()
    searchPlaceController.delegate = self
    present(searchPlaceController, animated: true, completion: nil)
  }
}

// General UICollectionViewDelegateFlowLayout
extension HomeController: UICollectionViewDelegateFlowLayout {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return weather?.list?.count ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dailyWeatherCellId, for: indexPath) as! DailyWeatherCell
    if let weather = self.weather?.list?[indexPath.item] {
      cell.weather = weather
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 150)
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: dailyWeatherHeaderCell, for: indexPath) as! DailyWeatherHeaderCell
    if let weather = self.weather {
      if let weather = weather.list?.first {
        header.weather = weather
      }
      if let cityName = weather.city?.name {
        header.cityName = cityName
      }
    }
    return header
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return .init(width: view.frame.width, height: 300)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}

// SearchPlaceController to HomeController
extension HomeController: GooglePlaceChangable {
  func change(place: GMSPlace) {
    self.place = place
  }
}
