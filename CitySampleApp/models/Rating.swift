//
//  Rating.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

class Rating {
    var id: String
    var rating: Float
    
    init(model: RatingResponseModel) {
        self.id = model.id
        self.rating = model.rating
    }
}
