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
}

extension CityScene: SceneType {
    func viewController() -> UIViewController? {
        switch self {
        case .cityList:
            return Resolver.root.resolve(CityListViewController.self)
        }
    }
}
