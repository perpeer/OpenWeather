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
  
  // GooglePlaceChangable delegate
  var delegate: GooglePlaceChangable?
    
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    setupResultsController()
    setupSearchBar()
  }
  
}

// Layout
extension SearchPlaceController {
  fileprivate func setupResultsController() {
    // google api delegate
    resultsViewController = GMSAutocompleteResultsViewController()
    resultsViewController?.delegate = self
    resultsViewController?.tableCellBackgroundColor = .white
    resultsViewController?.tableCellSeparatorColor = .black
    resultsViewController?.primaryTextColor = .black
    resultsViewController?.primaryTextHighlightColor = .blue
    resultsViewController?.secondaryTextColor = .black
  }
  
  fileprivate func setupSearchBar() {
    searchController = UISearchController(searchResultsController: resultsViewController)
    searchController?.searchResultsUpdater = resultsViewController
    
    view.addSubview(subView)
    subView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 150))
    
    subView.addSubview((searchController?.searchBar)!)
    searchController?.searchBar.sizeToFit()
    searchController?.hidesNavigationBarDuringPresentation = false
    definesPresentationContext = true
  }
}

extension SearchPlaceController: GMSAutocompleteResultsViewControllerDelegate {
  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didAutocompleteWith place: GMSPlace) {
    searchController?.isActive = false
    delegate?.change(place: place)
    dismiss(animated: true, completion: nil)
  }
  
  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didFailAutocompleteWithError error: Error){
    print("Error: ", error.localizedDescription)
  }
}
