//
//  DependencyInjectionTests.swift
//  CitySampleAppTests
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import XCTest
@testable import CitySampleApp

class DependencyInjectionTests: XCTestCase {

    private var cityListVM: CityListViewModelType?
    private var cityDetailsVM: CityDetailsViewModelType?
    private var visitorListVM: VisitorListViewModelType?
    
    private var cityListVC: CityListViewController?
    private var cityDetailsVC: CityDetailsViewController?
    private var visitorListVC: VisitorListViewController?

    override func setUp() {
        let city = City(id: "1", name: "test", previewUrl: "", isFavorite: false)
        let visitors = [Visitor(id: "1", name: "test")]
        
        cityListVM = Resolver.root.resolve(CityListViewModelType.self)
        cityDetailsVM = Resolver.root.resolve(CityDetailsViewModelType.self, arg: city)
        visitorListVM = Resolver.root.resolve(VisitorListViewModelType.self, arg: visitors)
        
        cityListVC = Resolver.root.resolve(CityListViewController.self)
        cityDetailsVC = Resolver.root.resolve(CityDetailsViewController.self, arg: city)
        visitorListVC = Resolver.root.resolve(VisitorListViewController.self, arg: visitors)
    }
    
    func testViewModelResolver() {
        XCTAssertNotNil(cityListVM)
        XCTAssertNotNil(cityDetailsVM)
        XCTAssertNotNil(visitorListVM)
    }
    
    func testViewControllersResolver() {
        XCTAssertNotNil(cityListVC)
        XCTAssertNotNil(cityDetailsVC)
        XCTAssertNotNil(visitorListVC)
    }
}
