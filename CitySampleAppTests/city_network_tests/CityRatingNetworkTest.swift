//
//  CityRatingNetworkTest.swift
//  CitySampleAppTests
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import XCTest

@testable import CitySampleApp

class CityRatingNetworkTest: XCTestCase {

    private var cityNetwork: CityNetwork!
    private var network: MockNetwork!
    
    private var mockData: Data!
    private var mockError: Error!
    private var mockRating: RatingResponseModel!
    private var city: City!
    
    override func setUp() {
        cityNetwork = CityNetwork()
        network = MockNetwork()
        cityNetwork.$network.wrappedValue = network
        setupProperties()
    }
    
    private func setupProperties() {
        city = City(id: "1", name: "test", previewUrl: "", isFavorite: false)
        mockData = TestNetworkData.ratingtData
        mockError = TestError.dummyError1
        mockRating = TestRouterData.ratingtData
    }
    
    func testWhenFetchRatingReturnsCorrectModel() {
        network.fetchResult = .success(mockData)
    
        let fetchedResult = fetchRatingWithSuccess()
        
        XCTAssertEqual(fetchedResult, mockRating)
    }

    func testWhenFetchRatingReturnsInCorrectModel() {
        let expectedResult = RatingResponseModel(id: "1", rating: 1)
        network.fetchResult = .success(mockData)
        
        let fetchedResult = fetchRatingWithSuccess()
        
        XCTAssertNotEqual(fetchedResult, expectedResult)
    }
    
    func testWhenFetchRatingReturnsError() {
        network.fetchResult = .failure(mockError)
        let fetchedResult = fetchRatingWithFailure()
        
        XCTAssertEqual(fetchedResult?.localizedDescription, mockError.localizedDescription)
    }
    
    private func fetchRatingWithSuccess() -> RatingResponseModel? {
        var responseResult: RatingResponseModel?
        
        cityNetwork.fetchCityRating(city: city) { (result) in
            switch result {
            case .success(let data): responseResult = data
            default: break
            }
        }
        
        return responseResult
    }
    
    private func fetchRatingWithFailure() -> Error? {
        var responseResult: Error?
        
        cityNetwork.fetchCityRating(city: city) { (result) in
            switch result {
            case .failure(let error): responseResult = error
            default: break
            }
        }
        
        return responseResult
    }

}
