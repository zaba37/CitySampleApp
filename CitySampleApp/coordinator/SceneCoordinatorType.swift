//
//  SceneCoordinatorType.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 19/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import UIKit

protocol SceneCoordinatorType {
    typealias NavigateBackCompletion = (()->())
    
    func set(window: UIWindow)
    func transition(to scene: SceneType, type: SceneTransitionType)
    func pop(animated: Bool)
}
