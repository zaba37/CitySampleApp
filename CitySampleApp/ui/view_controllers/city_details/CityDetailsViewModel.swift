//
//  CityDetailsViewModel.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

class CityDetailsViewModel: CityDetailsViewModelType {
    //MARK: - Injected properties
    @Injected private var network: CityNetworkType
    @Injected private var sceneCoordinator: SceneCoordinatorType
    @Injected var city: City
    
    //MARK: - Callbacks
    var didUpdate: ((DetailUpdateType, String) -> ())?
    var didError: ((DetailUpdateType, Error) -> ())?
    
    //MARK: - Private properties
    private var visitors = [Visitor]()
    
    //MARK: - Getters
    lazy var previewUrl: String = {
        return city.previewUrl
    }()
    lazy var cityName: String = {
        return city.name
    }()
    
    //MARK: - Life cycle
    init(city: City) {
        self.$city.wrappedValue = city
    }
    
    //MARK: - Networking
    func loadData() {
        network.fetchCityVisitors(city: city) { [weak self] (result) in
            switch result {
            case .success(let visitors):
                self?.visitors = visitors
                self?.didUpdate?(.visitors, String(format: "%d - %@", visitors.count, "visitors".localized))
            case .failure(let error):
                self?.didError?(.visitors, error)
            }
        }
        
        network.fetchCityRating(city: city) { [weak self] (result) in
            switch result {
            case .success(let rating):
                self?.didUpdate?(.rating, String(format: "%1.2f - %@", rating.rating, "rating".localized))
            case .failure(let error):
                self?.didError?(.rating, error)
            }
        }
    }
    
    //MARK: - Actions
    func showVisitorsList() {
        
    }
}
