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
}
