//
//  CityNetwork.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

protocol CityNetworkType {
    func fetchCityList(completion: @escaping (Result<[CityResponseModel], Error>) -> Void)
    func fetchCityRating(city: City, completion: @escaping (Result<RatingResponseModel, Error>) -> Void)
    func fetchCityVisitors(city: City, completion: @escaping (Result<[VisitorResponseModel], Error>) -> Void)
}

class CityNetwork: CityNetworkType {
    //MARK: - Injected properties
    @Injected var network: NetworkType
    
    //MARK: - Networking
    func fetchCityList(completion: @escaping (Result<[CityResponseModel], Error>) -> Void) {
        network.requestData(request: CityRouter.fetchCityList) { result in
            switch result {
            case .success(let data):
                do {
                    let cityList = try JSONDecoder().decode([CityResponseModel].self, from: data)
                    completion(.success(cityList))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCityRating(city: City, completion: @escaping (Result<RatingResponseModel, Error>) -> Void) {
        ///Request model is unused on this sample application but is prepared to show how pass parameters to network request
        let request = CityRatingRequestModel(cityId: city.id)
        network.requestData(request: CityRouter.fetchCityRating(request: request)) { result in
            switch result {
            case .success(let data):
                do {
                    let rating = try JSONDecoder().decode(RatingResponseModel.self, from: data)
                    completion(.success(rating))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCityVisitors(city: City, completion: @escaping (Result<[VisitorResponseModel], Error>) -> Void) {
        ///Request model is unused on this sample application but is prepared to show how pass parameters to network request
        let request = CityVisitorsRequestModel(cityId: city.id)
        network.requestData(request: CityRouter.fetchCityVisitors(request: request)) { result in
            switch result {
            case .success(let data):
                do {
                    let visitorList = try JSONDecoder().decode([VisitorResponseModel].self, from: data)
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
