//
//  CityListViewModelType.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

protocol CityListViewModelType {
    var didUpdate: (()->())? { get set }
    var didError: ((Error)->())? { get set }
    var cellViewModelTypes: [CellViewModelType.Type] { get }
    var citiesCount: Int { get }
    
    func loadData()
    func onViewWillAppear()
    func toggleFavoriteFilter()
    func cityViewModel(atRow row: Int) -> CityCellViewModel?
    func onSelect(row: Int)
}
