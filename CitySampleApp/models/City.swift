//
//  City.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

class City: Codable {
    var id: String
    var name: String
    var previewUrl: String
    var isFavorite: Bool = false
    
    init(id: String, name: String, previewUrl: String, isFavorite: Bool) {
        self.id = id
        self.name = name
        self.previewUrl = previewUrl
        self.isFavorite = isFavorite
    }
    
    init(model: CityResponseModel) {
        self.id = model.id
        self.name = model.name
        self.previewUrl = model.previewUrl
    }
    
    func setFavorite(isFovrite: Bool) {
        self.isFavorite = isFovrite
    }
}

extension City: Equatable, Hashable {
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
