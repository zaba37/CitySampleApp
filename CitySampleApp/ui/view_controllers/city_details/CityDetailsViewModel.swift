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
    @Injected private var database: DatabaseServiceType
    @Injected private var city: City
    
    //MARK: - Callbacks
    var didUpdate: ((DetailUpdateType, String?) -> ())?
    var didError: ((DetailUpdateType, Error) -> ())?
    var didLoadData: (() -> ())?
    
    //MARK: - Private properties
    private var visitors = [Visitor]()
    
    //MARK: - Getters
    lazy var previewUrl: String = {
        return city.previewUrl
    }()
    lazy var cityName: String = {
        return city.name
    }()
    
    var isFavorite: Bool {
        return city.isFavorite
    }
    
    //MARK: - Life cycle
    init(city: City) {
        self.$city.wrappedValue = city
    }
    
    //MARK: - Networking
    func loadData() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        network.fetchCityVisitors(city: city) { [weak self] (result) in
            switch result {
            case .success(let visitors):
                self?.visitors = visitors.map { Visitor(model: $0) }
                self?.didUpdate?(.visitors, String(format: "%d - %@", visitors.count, "visitors".localized))
            case .failure(let error):
                self?.didError?(.visitors, error)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        network.fetchCityRating(city: city) { [weak self] (result) in
            switch result {
            case .success(let rating):
                self?.didUpdate?(.rating, String(format: "%1.2f - %@", rating.rating, "rating".localized))
            case .failure(let error):
                self?.didError?(.rating, error)
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.didLoadData?()
        }
    }
    
    //MARK: - Actions
    func setFavorite() {
        let model = city
        
        do {
            model.isFavorite = !model.isFavorite
            try database.saveFavorite(model: model)
            city = model
            didUpdate?(.favoriteSave, nil)
        } catch {
            didError?(.favoriteSave, error)
        }
    }
    
    func showVisitorsList() {
        sceneCoordinator.transition(to: CityScene.visitorsList(visitors: visitors), type: .modal)
    }
}
