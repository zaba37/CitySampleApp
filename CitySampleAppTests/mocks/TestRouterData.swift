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
        guard let cityList = try? JSONDecoder().decode([CityResponseModel].self, from: TestNetworkData.cityListData) else {
                return []
        }
        
        return cityList
    }()
    
    static let visitorsData: [VisitorResponseModel] = {
        guard let visitorList = try? JSONDecoder().decode([VisitorResponseModel].self, from: TestNetworkData.visitorsData) else {
                return []
        }
        
        return visitorList
    }()

    static let ratingtData: RatingResponseModel = {
        guard let rating = try? JSONDecoder().decode(RatingResponseModel.self, from: TestNetworkData.ratingtData) else {
                return RatingResponseModel(id: "1", rating: 0)
        }
        
        return rating
    }()
}
