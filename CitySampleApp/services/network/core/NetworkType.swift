//
//  NetworkType.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

protocol NetworkType {
    func requestData(request: RouterType, completion: @escaping (Result<Data, Error>) -> Void)
}
