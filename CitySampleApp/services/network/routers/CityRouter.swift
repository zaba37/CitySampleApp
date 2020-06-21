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
    
    var path: String {
        switch self {
        case .fetchCityList: return "/5eefd38897cb753b4d153914/1"
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
