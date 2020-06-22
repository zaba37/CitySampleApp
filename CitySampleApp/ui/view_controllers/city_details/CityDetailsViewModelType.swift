//
//  CityDetailsViewModelType.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

protocol CityDetailsViewModelType {
    var previewUrl: String { get }
    var cityName: String { get }
    var didUpdate: ((DetailUpdateType, String)->())? { get set }
    var didError: ((DetailUpdateType, Error)->())? { get set }
    
    func loadData()
    func showVisitorsList() 
}
