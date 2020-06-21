//
//  NetworkError.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidURL(String)
    case invalidResponse
    case noData
    case serializationError
}
