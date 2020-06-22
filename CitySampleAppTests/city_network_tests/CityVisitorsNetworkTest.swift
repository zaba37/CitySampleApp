//
//  CityVisitorsNetworkTest.swift
//  CitySampleAppTests
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import XCTest

@testable import CitySampleApp

class CityVisitorsNetworkTest: XCTestCase {

    private var cityNetwork: CityNetwork!
    private var network: MockNetwork!
    
    private var mockData: Data!
    private var mockError: Error!
    private var mockVisitorList: [VisitorResponseModel]!
    private var city: City!
    
    override func setUp() {
        cityNetwork = CityNetwork()
        network = MockNetwork()
        cityNetwork.$network.wrappedValue = network
        setupProperties()
    }
    
    private func setupProperties() {
        city = City(id: "1", name: "test", previewUrl: "", isFavorite: false)
        mockData = TestNetworkData.visitorsData
        mockError = TestError.dummyError1
        mockVisitorList = TestRouterData.visitorsData
    }
    
    func testWhenFetchVisitorsListReturnsCorrectModel() {
        network.fetchResult = .success(mockData)
    
        let fetchedResult = fetchVisitorsListWithSuccess()
        
        XCTAssertEqual(fetchedResult, mockVisitorList)
    }

    func testWhenFetchVisitorsListReturnsInCorrectModel() {
        let expectedResult = [VisitorResponseModel]()
        network.fetchResult = .success(mockData)
        
        let fetchedResult = fetchVisitorsListWithSuccess()
        
        XCTAssertNotEqual(fetchedResult, expectedResult)
    }
    
    func testWhenFetchVisitorsListReturnsCorrectCityCount() {
        network.fetchResult = .success(mockData)
        
        let fetchedResult = fetchVisitorsListWithSuccess()
        
        XCTAssertEqual(fetchedResult.count, mockVisitorList.count)
    }
    
    func testWhenFetchVisitorsListReturnsError() {
        network.fetchResult = .failure(mockError)
        let fetchedResult = fetchVisitorsListWithFailure()
        
        XCTAssertEqual(fetchedResult?.localizedDescription, mockError.localizedDescription)
    }
    
    private func fetchVisitorsListWithSuccess() -> [VisitorResponseModel] {
        var responseResult = [VisitorResponseModel]()
        
        cityNetwork.fetchCityVisitors(city: city) { (result) in
            switch result {
            case .success(let data): responseResult = data
            default: break
            }
        }
        
        return responseResult
    }
    
    private func fetchVisitorsListWithFailure() -> Error? {
        var responseResult: Error?
        
        cityNetwork.fetchCityVisitors(city: city) { (result) in
            switch result {
            case .failure(let error): responseResult = error
            default: break
            }
        }
        
        return responseResult
    }

}
