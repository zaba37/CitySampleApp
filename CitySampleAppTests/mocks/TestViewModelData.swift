//
//  TestViewModelData.swift
//  CitySampleAppTests
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

@testable import CitySampleApp

class TestViewModelData {
    static let cityListData: [City] = {
        return TestRouterData.cityListData.map { City(model: $0) }
    }()
    
    static let visitorsData: [Visitor] = {
        return TestRouterData.visitorsData.map { Visitor(model: $0) }
    }()

    static let ratingtData: Rating = {
        return Rating(model: TestRouterData.ratingtData)
    }()
}
