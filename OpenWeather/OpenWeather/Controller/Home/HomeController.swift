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
  
  private var place: GMSPlace? {
    didSet {
      print("reloadData")
      collectionView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(DailyWeatherCell.self, forCellWithReuseIdentifier: dailyWeatherCellId)
    
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
    return 5
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dailyWeatherCellId, for: indexPath) as! DailyWeatherCell
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 100)
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
