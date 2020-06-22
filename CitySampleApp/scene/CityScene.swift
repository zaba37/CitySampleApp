//
//  CityScene.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import UIKit

enum CityScene {
    case cityList
    case cityDetails(city: City)
    case visitorsList(visitors: [Visitor])
}

extension CityScene: SceneType {
    func viewController() -> UIViewController? {
        switch self {
        case .cityList:
            return Resolver.root.resolve(CityListViewController.self)
        case .cityDetails(let city):
            return Resolver.root.resolve(CityDetailsViewController.self, arg: city)
        case .visitorsList(let visitors):
            return Resolver.root.resolve(VisitorListViewController.self, arg: visitors)
        }
    }
}
