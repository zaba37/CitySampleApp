//
//  CityListNetworkTest.swift
//  CitySampleAppTests
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import XCTest

@testable import CitySampleApp

class CityListNetworkTest: XCTestCase {

    private var cityNetwork: CityNetwork!
    private var network: MockNetwork!
    
    private var mockData: Data!
    private var mockError: Error!
    private var mockCityList: [CityResponseModel]!
    
    override func setUp() {
        cityNetwork = CityNetwork()
        network = MockNetwork()
        cityNetwork.$network.wrappedValue = network
        setupProperties()
    }
    
    private func setupProperties() {
        mockData = TestNetworkData.cityListData
        mockError = TestError.dummyError1
        mockCityList = TestRouterData.cityListData
    }
    
    func testWhenFetchCityListReturnsCorrectModel() {
        network.fetchResult = .success(mockData)
    
        let fetchedResult = fetchCityListWithSuccess()
        
        XCTAssertEqual(fetchedResult, mockCityList)
    }

    func testWhenFetchCityListReturnsInCorrectModel() {
        let expectedResult = [CityResponseModel]()
        network.fetchResult = .success(mockData)
        
        let fetchedResult = fetchCityListWithSuccess()
        
        XCTAssertNotEqual(fetchedResult, expectedResult)
    }
    
    func testWhenFetchCityListReturnsCorrectCityCount() {
        network.fetchResult = .success(mockData)
        
        let fetchedResult = fetchCityListWithSuccess()
        
        XCTAssertEqual(fetchedResult.count, mockCityList.count)
    }
    
    func testWhenFetchCityListReturnsError() {
        network.fetchResult = .failure(mockError)
        let fetchedResult = fetchCityListWithFailure()
        
        XCTAssertEqual(fetchedResult?.localizedDescription, mockError.localizedDescription)
    }
    
    private func fetchCityListWithSuccess() -> [CityResponseModel] {
        var responseResult = [CityResponseModel]()
        
        cityNetwork.fetchCityList { (result) in
            switch result {
            case .success(let data): responseResult = data
            default: break
            }
        }
        
        return responseResult
    }
    
    private func fetchCityListWithFailure() -> Error? {
        var responseResult: Error?
        
        cityNetwork.fetchCityList { (result) in
            switch result {
            case .failure(let error): responseResult = error
            default: break
            }
        }
        
        return responseResult
    }
}
