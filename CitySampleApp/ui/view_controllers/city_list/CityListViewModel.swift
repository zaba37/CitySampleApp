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
    @Injected var network: CityNetworkType
    @Injected private var sceneCoordinator: SceneCoordinatorType
    @Injected private var database: DatabaseServiceType
    
    //MARK: - Private properties
    private var cityCellViewModels = [CityCellViewModel]()
    private var filteredCellViewModels = [CityCellViewModel]()
    private var favoriteFilter = false
    
    //MARK: - Public properties
    let cellViewModelTypes: [CellViewModelType.Type] = [CityCellViewModel.self]
    
    //MARK: - Callbacks
    var didUpdate: (()->())?
    var didError: ((Error)->())?
    
    //MARK: - Getters
    var citiesCount: Int {
        return filteredCellViewModels.count
    }
    
    //MARK: - Networking
    func loadData() {
        network.fetchCityList { [weak self] result in
            switch result {
            case .success(let cityList):
                let mappedList = cityList.map {
                    City(model: $0)
                }
                
                mappedList.forEach( { [weak self] city in
                    guard let self = self else { return }
                    city.setFavorite(isFovrite: self.database.isFavorite(model: city))
                })
                
                self?.prepareViewModels(for: mappedList)
            case .failure(let error):
                self?.didError?(error)
            }
        }
    }

    //MARK - Actions
    func onSelect(row: Int) {
        guard let selected = cityViewModel(atRow: row) else { return }
        sceneCoordinator.transition(to: CityScene.cityDetails(city: selected.city), type: .push)
    }
    
    func toggleFavoriteFilter() {
        favoriteFilter = !favoriteFilter
        filterDatasource()
    }
    
    //MARK: - Utils
    func onViewWillAppear() {
        cityCellViewModels.forEach { (model) in
            model.city.setFavorite(isFovrite: self.database.isFavorite(model: model.city))
        }
        filterDatasource()
    }
    
    func cityViewModel(atRow row: Int) -> CityCellViewModel? {
        guard 0 ..< citiesCount ~= row else {
            return nil
        }
        return filteredCellViewModels[row]
    }
    
    private func prepareViewModels(for cityList: [City]) {
        cityCellViewModels = cityList.map { CityCellViewModel(city: $0) }
        filterDatasource()
    }
    
    private func filterDatasource() {
        guard favoriteFilter else {
            filteredCellViewModels = cityCellViewModels
            didUpdate?()
            return
        }
        
        filteredCellViewModels = cityCellViewModels.filter { $0.isFavorite }
        didUpdate?()
    }
}
