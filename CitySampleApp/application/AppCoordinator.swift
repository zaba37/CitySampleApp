//
//  AppCoordinator.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 19/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    //MARK: Injected properties
    @Injected var sceneCoordinator: SceneCoordinatorType

    //MARK: - Start App
    func start(window: UIWindow?) {
        guard let window = window else { return }
        sceneCoordinator.set(window: window)
        sceneCoordinator.transition(to: CityScene.cityList, type: .root)
    }

    
}
