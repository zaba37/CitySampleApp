//
//  CityCellViewModelType.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

protocol CityCellViewModelType {
    var cityName: String { get }
    var previewUrl: String { get }
    var isFavorite: Bool { get }
}
