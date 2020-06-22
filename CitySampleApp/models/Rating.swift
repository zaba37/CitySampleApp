//
//  Rating.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

struct Rating: Codable {
    var id: String
    var rating: Float
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case rating
    }
}
