//
//  CityListViewModelTest.swift
//  CitySampleAppTests
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import XCTest

@testable import CitySampleApp

class CityListViewModelTest: XCTestCase {

    private var cityNetwork: CityNetwork!
    private var network: MockNetwork!
    private var viewModel: CityListViewModel!
    
    private var correctDataList: [City]!
    private let mockData = TestNetworkData.cityListData
    private let mockError = TestError.dummyError1
    
    override func setUp() {
        cityNetwork = CityNetwork()
        network = MockNetwork()
        cityNetwork.$network.wrappedValue = network
        correctDataList = TestViewModelData.cityListData
        
        let viewModel = CityListViewModel()
        viewModel.$network.wrappedValue = cityNetwork
        
        self.viewModel = viewModel
    }

    func testViewModelCallDidUpdate() {
        var isCalled = false
        network.fetchResult = .success(mockData)
        
        
        viewModel.didUpdate = {
            isCalled = true
        }
        
        viewModel.loadData()
        XCTAssertTrue(isCalled)
    }
    
    func testViewModelCallDidError() {
        var error: Error?
        network.fetchResult = .failure(mockError)
        
        
        viewModel.didError = { result in
            error = result
        }
        
        viewModel.loadData()
        
        XCTAssertNotNil(error)
        XCTAssertEqual(error?.localizedDescription, mockError.localizedDescription)
    }
    
    func testWhenVieModelLoadCorrectDataCount() {
        network.fetchResult = .success(mockData)
        viewModel.loadData()
        XCTAssertEqual(viewModel.citiesCount, correctDataList.count)
    }
}
