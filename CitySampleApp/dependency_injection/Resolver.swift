//
//  Resolver.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 19/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

protocol ResolverType {
    func resolve<ServiceType>(_ type: ServiceType.Type) -> ServiceType?
    func resolve<ServiceType, Arg>(_ type: ServiceType.Type, arg: Arg) -> ServiceType?
}

class Resolver: ResolverType {

    static let root = Resolver(factories: [])
    
    var factories = [AnyServiceFactory]()
    
    private init(factories: [AnyServiceFactory]) {
        self.factories = factories
    }

    // MARK: Register
    func register<ServiceType>(_ type: ServiceType.Type, _ factory: @escaping (ResolverType) -> ServiceType) {
        assert(!factories.contains(where: { $0.supports(type) }))
        
        let newFactory = ServiceFactory<ServiceType, Any>(type, factory: { resolver in
            factory(resolver)
        })
        
        factories.append(AnyServiceFactory(newFactory))
    }
    
    func register<ServiceType, Arg>(_ type: ServiceType.Type, _ factory: @escaping (ResolverType, Arg) -> ServiceType) {
        assert(!factories.contains(where: { $0.supports(type, argType: Arg.self) }))
        
        let newFactory = ServiceFactory<ServiceType, Arg>(type, factory: { resolver, arg in
            factory(resolver, arg)
        })
        
        factories.append(AnyServiceFactory(newFactory))
    }

    // MARK: Resolver
    func resolve<ServiceType>(_ type: ServiceType.Type) -> ServiceType? {
        guard let factory = factories.first(where: { $0.supports(type) }) else {
            return nil
        }
        return factory.resolve(self)
    }
    
    func resolve<ServiceType, Arg>(_ type: ServiceType.Type, arg: Arg) -> ServiceType? {
        guard let factory = factories.first(where: { $0.supports(type, argType: Arg.self) }) else {
            return nil
        }
        return factory.resolve(self, arg: arg)
    }
}
