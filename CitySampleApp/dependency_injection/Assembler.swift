//
//  Assembler.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 19/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import UIKit

struct Assembler {
    func registerAllDependencies() {
        
        let resolver = Resolver.root
        
        //MARK: - App
        resolver.register(AppCoordinator.self) { r in
            return AppCoordinator()
        }
        
        //MARK: - Network
        resolver.register(URLSession.self) { r in
            return URLSession(configuration: URLSessionConfiguration.ephemeral)
        }

        resolver.register(URLSession.self) { (r, sessionConfig: URLSessionConfiguration) in
            return URLSession(configuration: sessionConfig)
        }
        
        resolver.register(NetworkType.self) { (r, session: URLSession) in
            let network = Network()
            network.$session.wrappedValue = session
            return network
        }

        resolver.register(NetworkType.self) { r in
            return Network()
        }

//        resolver.register(WeatherNetworkType.self) { r in
//            return WeatherNetwork()
//        }

        resolver.register(CityNetworkType.self) { r in
            let sessionConfig = URLSessionConfiguration.ephemeral
            //sessionConfig.protocolClasses = [UrlProtocolMock.self]
            let session = r.resolve(URLSession.self, arg: sessionConfig)!
            let network = r.resolve(NetworkType.self, arg: session)!
            let cityNetwork = CityNetwork()
            cityNetwork.$network.wrappedValue = network
            return cityNetwork
        }
        
        //MARK: - Coordinator
        resolver.register(SceneCoordinatorType.self) { r in
            return SceneCoordinator.shared
        }

        //MARK: - ViewModels
        resolver.register(CityListViewModelType.self) { r in
            return CityListViewModel()
        }

        resolver.register(CityDetailsViewModelType.self) { (r, city: City) in
            return CityDetailsViewModel(city: city)
        }
        
        //MARK: - ViewControllers
        resolver.register(CityListViewController.self) { r in
            return CityListViewController()
        }

        resolver.register(CityDetailsViewController.self) { (r, city: City) in
            let vc = CityDetailsViewController()
            let vm = r.resolve(CityDetailsViewModelType.self, arg: city)!
            vc.$viewModel.wrappedValue = vm
            return vc
        }
        
    }
}
