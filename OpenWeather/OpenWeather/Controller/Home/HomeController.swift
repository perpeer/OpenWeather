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
    collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)

    weatherDataFetchWith(cityName: "ankara")
    
    setupNavControllerLayout()
    setupBottomToolbar()
  }
  
  fileprivate func setupBottomToolbar() {
    let toolbarView = UIView()
    toolbarView.backgroundColor = UIColor.rgb(red: 241, green: 196, blue: 15)
    view.addSubview(toolbarView)
    toolbarView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, size: .init(width: 0, height: 80))
    let fahrenheitLabel = UILabel(text: "°F", font: .boldSystemFont(ofSize: 22))
    let celsiusLabel = UILabel(text: "°C", font: .boldSystemFont(ofSize: 22))
    celsiusLabel.textAlignment = .right
    let switchButton = UISwitch()
    
    toolbarView.addSubview(switchButton)
    switchButton.anchor(top: nil, leading: nil, bottom: nil, trailing: nil)
    switchButton.centerXAnchor.constraint(equalTo: toolbarView.centerXAnchor).isActive = true
    switchButton.centerYAnchor.constraint(equalTo: toolbarView.centerYAnchor).isActive = true
    
    toolbarView.addSubview(celsiusLabel)
    celsiusLabel.anchor(top: toolbarView.topAnchor, leading: toolbarView.leadingAnchor, bottom: toolbarView.bottomAnchor, trailing: switchButton.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 8))
    
    toolbarView.addSubview(fahrenheitLabel)
    fahrenheitLabel.anchor(top: toolbarView.topAnchor, leading: switchButton.trailingAnchor, bottom: toolbarView.bottomAnchor, trailing: toolbarView.trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 0))
    switchButton.addTarget(self, action: #selector(handleDegreeSwitchButton), for: .valueChanged)
  }
  
  @objc func handleDegreeSwitchButton(_ sender: UISwitch!) {
    print(sender.isOn)
    if sender.isOn {
      Constants.DegreeTypeValue = .Fahrenheit
    } else {
      Constants.DegreeTypeValue = .Celsius
    }
    collectionView.reloadData()
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
