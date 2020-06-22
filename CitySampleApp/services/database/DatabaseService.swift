//
//  DatabaseService.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

class DatabaseService: DatabaseServiceType {
    
    static let shared = DatabaseService()
    
    //MARK: - Private properties
    private let userDefaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let cityKey = "cities_key"
    
    //MARK: - Utils
    func saveFavorite(model: City) throws {
        var loadedList = loadData()
        
        do {
            loadedList.removeAll(where: { $0 == model })
            loadedList.append(model)
            
            let encodedData = try encoder.encode(loadedList)
            userDefaults.set(encodedData, forKey: cityKey)
        } catch {
            throw error
        }
    }
    
    func isFavorite(model: City) -> Bool {
        let cities = loadData()
        
        guard let city = cities.first(where: { $0 == model }) else {
            return false
        }
        
        return city.isFavorite
    }
    
    private func loadData() -> [City] {
        guard let citiesData = userDefaults.data(forKey: cityKey),
            let cities = try? decoder.decode([City].self, from: citiesData) else {
                return []
        }
        
        return cities
    }
}
