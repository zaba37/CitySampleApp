//
//  DatabaseServiceType.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

protocol DatabaseServiceType {
    func saveFavorite(model: City) throws
    func isFavorite(model: City) -> Bool
}
