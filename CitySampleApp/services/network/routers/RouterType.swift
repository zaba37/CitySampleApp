//
//  RouterType.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

protocol RouterType {
    //MARK: - Properties
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: JSON { get }
    var encoding: EncodingType { get }
    
    //MARK: - Functions
    func asUrlRequest() throws -> URLRequest
}

//MARK: - RouterType extension
extension RouterType {
    var baseUrl: String {
        return AppConfiguration.baseUrl
    }
    
    var encoding: EncodingType {
        return URLEncoding()
    }
    
    func asUrlRequest() throws -> URLRequest {
        let url = baseUrl + path
        guard let requestUrl = URL(string: url) else { throw NetworkError.invalidURL(url) }
       
        var request = URLRequest(url: requestUrl)
        request.httpMethod = method.rawValue
        
        request = try encoding.encode(request, with: parameters)
        
        return request
    }
}
