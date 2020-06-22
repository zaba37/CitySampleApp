//
//  TestNetworkData.swift
//  CitySampleAppTests
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

class TestNetworkData {
    static let cityListData: Data = {
        guard let path = Bundle(for: TestNetworkData.self).path(forResource: "city_list", ofType: "json")
            , let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return Data()
        }
        return jsonData
    }()
    
    static let visitorsData: Data = {
        guard let path = Bundle(for: TestNetworkData.self).path(forResource: "city_visitors", ofType: "json")
            , let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return Data()
        }
        return jsonData
    }()
    
    static let ratingtData: Data = {
        guard let path = Bundle(for: TestNetworkData.self).path(forResource: "city_rating", ofType: "json")
            , let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return Data()
        }
        return jsonData
    }()
}
