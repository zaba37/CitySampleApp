//
//  CityRouter.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

enum CityRouter: RouterType {
      
    case fetchCityList
    case fetchCityRating(request: CityRatingRequestModel)
    case fetchCityVisitors(request: CityVisitorsRequestModel)
    
    var path: String {
        switch self {
        case .fetchCityList:
            return "/5eefd38897cb753b4d153914/1"
        case .fetchCityRating:
            return "/5ef05797e2ce6e3b2c774024"
        case .fetchCityVisitors:
            return "/5eefe8582406353b2e0a211b"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: JSON {
        switch self {
        default:
            return [:]
        }
    }
}
