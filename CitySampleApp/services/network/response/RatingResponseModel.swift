//
//  RatingResponseModel.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

struct RatingResponseModel: Codable {
    var id: String
    var rating: Float
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case rating
    }
}

extension RatingResponseModel: Equatable {
    static func == (lhs: RatingResponseModel, rhs: RatingResponseModel) -> Bool {
        return lhs.id == rhs.id
    }
}
