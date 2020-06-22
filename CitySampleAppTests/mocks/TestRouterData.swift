//
//  TestRouterData.swift
//  CitySampleAppTests
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

@testable import CitySampleApp

class TestRouterData {
    static let cityListData: [CityResponseModel] = {
        guard let path = Bundle(for: TestRouterData.self).path(forResource: "city_list", ofType: "json")
            , let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path))
            , let cityList = try? JSONDecoder().decode([CityResponseModel].self, from: jsonData) else {
                return []
        }
        
        return cityList
    }()
    
    static let visitorsData: [VisitorResponseModel] = {
        guard let path = Bundle(for: TestRouterData.self).path(forResource: "city_visitors", ofType: "json")
            , let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path))
            , let visitorList = try? JSONDecoder().decode([VisitorResponseModel].self, from: jsonData) else {
                return []
        }
        
        return visitorList
    }()

    static let ratingtData: RatingResponseModel = {
        guard let path = Bundle(for: TestRouterData.self).path(forResource: "city_rating", ofType: "json")
            , let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path))
            , let rating = try? JSONDecoder().decode(RatingResponseModel.self, from: jsonData) else {
                return RatingResponseModel(id: "1", rating: 0)
        }
        
        return rating
    }()
}
