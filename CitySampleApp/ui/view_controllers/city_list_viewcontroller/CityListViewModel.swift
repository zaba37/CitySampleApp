//
//  CityListViewModel.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

class CityListViewModel: CityListViewModelType {
    
    //MARK: - Injected properties
    @Injected private var network: CityNetworkType
    @Injected private var sceneCoordinator: SceneCoordinatorType
    
    //MARK: - Private properties
    private var cityCellViewModels = [CityCellViewModel]()
    
    //MARK: - Public properties
    let cellViewModelTypes: [CellViewModelType.Type] = [CityCellViewModel.self]
    
    //MARK: - Callbacks
    var didUpdate: (()->())?
    var didError: ((Error)->())?
    
    //MARK: - Networking
    func loadData() {
        network.fetchCityList { [weak self] result in
            switch result {
            case .success(let cityList):
                self?.prepareViewModels(for: cityList)
            case .failure(let error):
                self?.didError?(error)
            }
        }
    }
    
    //MARK: - Utils
    private func prepareViewModels(for cityList: [City]) {
        cityCellViewModels = cityList.map { CityCellViewModel(city: $0) }
        didUpdate?()
    }
    
    //MARK: - Getters
    var citiesCount: Int {
        return cityCellViewModels.count
    }
    
    func cityViewModel(atRow row: Int) -> CityCellViewModel? {
        guard 0 ..< citiesCount ~= row else {
            return nil
        }
        return cityCellViewModels[row]
    }
    
    //MARK - Actions
    func onSelect(row: Int) {
//        guard let selected = cityViewModel(atRow: row) else { return }
//        sceneCoordinator.transition(to: WeatherScene.forecast(city: selected.city), type: .push)
    }
}
