//
//  SearchPlaceController.swift
//  OpenWeather
//
//  Created by Ekrem TAŞKIRAN on 21.11.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import UIKit
import GooglePlaces

class SearchPlaceController: UIViewController {
  
  var resultsViewController: GMSAutocompleteResultsViewController?
  var searchController: UISearchController?
  var resultView: UITextView?
  
  // Searchbar Views
  let subView = UIView()
  
  // GooglePlaceChangable delagate
  var delegate: GooglePlaceChangable?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    // google api delegate
    resultsViewController = GMSAutocompleteResultsViewController()
    resultsViewController?.delegate = self
    
    setupSearchBar()
  }
  
  fileprivate func setupSearchBar() {
    searchController = UISearchController(searchResultsController: resultsViewController)
    searchController?.searchResultsUpdater = resultsViewController
    
    view.addSubview(subView)
    subView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 150))
    
    subView.addSubview((searchController?.searchBar)!)
    searchController?.searchBar.sizeToFit()
    searchController?.hidesNavigationBarDuringPresentation = false
    
    // When UISearchController presents the results view, present it in
    // this view controller, not one further up the chain.
    definesPresentationContext = true
  }
}

// Handle the user's selection.
extension SearchPlaceController: GMSAutocompleteResultsViewControllerDelegate {
  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didAutocompleteWith place: GMSPlace) {
    searchController?.isActive = false
    // Do something with the selected place.
    print("Place name: \(String(describing: place.name))")
    print("Place address: \(String(describing: place.formattedAddress))")
    print("Place coordinate: \(String(describing: place.coordinate))")
    delegate?.change(place: place)
    dismiss(animated: true, completion: nil)
  }
  
  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didFailAutocompleteWithError error: Error){
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }
  
  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
//    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }
  
  func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
//    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }
}
