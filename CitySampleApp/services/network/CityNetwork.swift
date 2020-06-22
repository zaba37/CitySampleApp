//
//  CityNetwork.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

protocol CityNetworkType {
    func fetchCityList(completion: @escaping (Result<[City], Error>) -> Void)
    func fetchCityRating(city: City, completion: @escaping (Result<Rating, Error>) -> Void)
    func fetchCityVisitors(city: City, completion: @escaping (Result<[Visitor], Error>) -> Void)
}

class CityNetwork: CityNetworkType {
    //MARK: - Injected properties
    @Injected var network: NetworkType
    
    //MARK: - Networking
    func fetchCityList(completion: @escaping (Result<[City], Error>) -> Void) {
        network.requestData(request: CityRouter.fetchCityList) { result in
            switch result {
            case .success(let data):
                do {
                    let cityList = try JSONDecoder().decode([City].self, from: data)
                    completion(.success(cityList))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCityRating(city: City, completion: @escaping (Result<Rating, Error>) -> Void) {
        let request = CityRatingRequestModel(cityId: city.id)
        network.requestData(request: CityRouter.fetchCityRating(request: request)) { result in
            switch result {
            case .success(let data):
                do {
                    let rating = try JSONDecoder().decode(Rating.self, from: data)
                    completion(.success(rating))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCityVisitors(city: City, completion: @escaping (Result<[Visitor], Error>) -> Void) {
        let request = CityVisitorsRequestModel(cityId: city.id)
        network.requestData(request: CityRouter.fetchCityVisitors(request: request)) { result in
            switch result {
            case .success(let data):
                do {
                    let visitorList = try JSONDecoder().decode([Visitor].self, from: data)
                    completion(.success(visitorList))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
