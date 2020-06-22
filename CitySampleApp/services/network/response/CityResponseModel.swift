//
//  CityResponseModel.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

struct CityResponseModel: Codable {
    var id: String
    var name: String
    var previewUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "city_name"
        case previewUrl = "preview_image"
    }
}

extension CityResponseModel: Equatable {
    static func == (lhs: CityResponseModel, rhs: CityResponseModel) -> Bool {
        return lhs.id == rhs.id
    }
}
