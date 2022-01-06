//
//  LocalStorage.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/11/28.
//

import Foundation

class LocalStorage: ObservableObject{
    
    @Published var allFavorites = [String: Location]()
    @Published var lastRemoveCity: String = ""
    
    func getFavLocations() -> [Location] {
        var favLoc = [Location]()
        for value in allFavorites.values {
            favLoc.append(value)
        }
        return favLoc
    }
    
    
    func setFavorite(city: String, state: String, status: Bool) {
        let key = "Favorite&" + city + "&" + state
        if status {
            // Add Favorite
            UserDefaults.standard.set(true, forKey: key)
            allFavorites[key] = Location(city: city, state: state)
            print("Add: " + key)
        }
        else {
            // Remove Favorite
            UserDefaults.standard.removeObject(forKey: key)
            allFavorites.removeValue(forKey: key)
            lastRemoveCity = city
            print("Remove: " + key)
        }
    }
    
    func isFavorite(city: String, state: String) -> Bool {
        let key = "Favorite&" + city + "&" + state
        return UserDefaults.standard.bool(forKey: key)
    }
    
    func getAllFavorites(){
        allFavorites.removeAll()
        
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            print(key)
            if key.contains("Favorite") {
                let city = String(key.split(separator: "&")[1])
                let state = String(key.split(separator: "&")[2])
                allFavorites[key] = Location(city: city, state: state)
            }
        }
        print("GET ALL FAV: \(allFavorites)")
    }
    
    func removeAllFavorites() {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            if key.contains("Favorite") {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
}
