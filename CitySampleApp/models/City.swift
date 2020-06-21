//
//  City.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

struct City: Codable {
    var id: String
    var name: String
    var previewUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "city_name"
        case previewUrl = "preview_image"
    }
}
