//
//  CityListNetworkMock.swift
//  CitySampleAppTests
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

@testable import CitySampleApp

class MockNetwork: NetworkType {
    var fetchResult: Result<Data, Error>!
    
    func requestData(request: RouterType, completion: @escaping (Result<Data, Error>) -> Void) {
        switch fetchResult {
        case .success(let result):
            completion(.success(result))
        case .failure(let error):
            completion(.failure(error))
        case .none: break
        }
    }
}
