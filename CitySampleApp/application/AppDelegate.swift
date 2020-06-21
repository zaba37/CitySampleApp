//
//  AppDelegate.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 19/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    @Injected private var appCoordinator: AppCoordinator
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        Assembler().registerAllDependencies()
        
        window?.makeKeyAndVisible()
        appCoordinator.start(window: window)
        return true
    }
}

