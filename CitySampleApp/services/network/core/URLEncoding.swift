//
//  URLEncoding.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

protocol EncodingType {
    func encode(_ urlRequest: URLRequest, with parameters: JSON?) throws -> URLRequest
}

class URLEncoding: EncodingType {
    private let contentTypeHeaderKey = "Content-Type"
    private let urlEncodedHeaderValue = "application/x-www-form-urlencoded; charset=utf-8"
    
    func encode(_ urlRequest: URLRequest, with parameters: JSON?) throws -> URLRequest {
        guard let parameters = parameters else { return urlRequest }
        var urlRequest = urlRequest
        
        guard let url = urlRequest.url?.absoluteString
            , var urlComponents = URLComponents(string: url) else {
                throw NetworkError.invalidURL("")
        }
        
        let items = queryItems(parameters)
        urlComponents.queryItems = items
        urlRequest.url = urlComponents.url
        urlRequest.setValue(urlEncodedHeaderValue, forHTTPHeaderField: contentTypeHeaderKey)
        
        return urlRequest
    }
    
    private func queryItems(_ parameters: JSON) -> [URLQueryItem] {
        return parameters.compactMap { param -> URLQueryItem? in
            guard let stringValue = param.value as? String else { return nil }
            return URLQueryItem(name:param.key, value: stringValue)
        }
    }
}
