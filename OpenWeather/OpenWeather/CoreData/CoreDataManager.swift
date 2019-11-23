//
//  CoreDataManager.swift
//  OpenWeather
//
//  Created by Ekrem TAŞKIRAN on 22.11.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import CoreData

class CoreDataManager {
  static let shared = CoreDataManager()
  
  var cityName: String {
    get {
      if let cityName = fetchPreferences()?.cityName {
        return cityName
      }
      return Constants.CityName
    }
    set {
      update(value: newValue, key: .CityName)
    }
  }
  
  var degreeType: DegreeType {
    get {
      if let degreeType = fetchPreferences()?.degreeType {
        switch degreeType.uppercased() {
        case "C": return DegreeType.Celsius
        case "F": return DegreeType.Fahrenheit
        default: return DegreeType.Celsius
        }
      }
      return Constants.DegreeStatus
    }
    set {
      update(value: newValue.rawValue, key: .DegreeType)
    }
  }
  
  fileprivate enum PreferencesKeys: String {
    case CityName = "cityName"
    case DegreeType = "degreeType"
  }
  
  let persistentContainer: NSPersistentContainer = {
    let persistentContainer = NSPersistentContainer(name: "OpenWeatherDataModel")
    persistentContainer.loadPersistentStores { (storeDescription, error) in
      if let err = error {
        fatalError("Loading of store failed: \(err)")
      }
    }
    return persistentContainer
  }()
  
  fileprivate func fetchPreferences() -> Preferences? {
    let context = persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<Preferences>(entityName: "Preferences")
    do {
      let preferences = try context.fetch(fetchRequest)
      if !preferences.isEmpty {
        return preferences.first
      } else {
        return nil
      }
    } catch let fetchErr {
      print("Failed to fetch preferences:", fetchErr)
      return nil
    }
  }
  
  fileprivate func update(value: String, key: PreferencesKeys) {
    let context = persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<Preferences>(entityName: "Preferences")
    
    do {
      let fetch = try context.fetch(fetchRequest)
      if let objectUpdate = fetch.first {
        objectUpdate.setValue(value, forKey: key.rawValue)
        try context.save()
      } else {
        create(value: value, key: key)
      }
    } catch let updateErr {
      print("Failed to update preferences:", updateErr)
    }
  }
  
  fileprivate func create(value: String, key: PreferencesKeys) {
    let context = persistentContainer.viewContext
    let preferences = NSEntityDescription.insertNewObject(forEntityName: "Preferences", into: context)
    
    preferences.setValue(value, forKey: key.rawValue)
    do {
      try context.save()
    } catch let saveErr {
      print("Failed to save preferences:", saveErr)
    }
  }
}


