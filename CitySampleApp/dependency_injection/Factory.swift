//
//  Factory.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 19/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

protocol FactoryType {
    associatedtype ServiceType
    associatedtype Arg
    
    func resolve(_ resolver: ResolverType) -> ServiceType
    func resolve(_ resolver: ResolverType, arg: Arg) -> ServiceType
}

extension FactoryType {
    func supports<T>(_ type: T.Type) -> Bool {
        return type == ServiceType.self
    }
    
    func supports<T, A>(_ type: T.Type, argType: A.Type) -> Bool {
        return type == ServiceType.self && argType == Arg.self
    }
}

struct ServiceFactory<ServiceType, Arg>: FactoryType {
    private var factory: ((ResolverType) -> ServiceType)?
    private var factoryArg: ((ResolverType, Arg) -> ServiceType)?
    
    init(_ type: ServiceType.Type, factory: @escaping (ResolverType) -> ServiceType) {
        self.factory = factory
    }
    
    init(_ type: ServiceType.Type, factory: @escaping (ResolverType, Arg) -> ServiceType) {
        self.factoryArg = factory
    }
    
    func resolve(_ resolver: ResolverType) -> ServiceType {
        return factory!(resolver)
    }
    
    func resolve(_ resolver: ResolverType, arg: Arg) -> ServiceType {
        return factoryArg!(resolver, arg)
    }
}

final class AnyServiceFactory {
    
    private var _resolve: ((ResolverType) -> Any)?
    private var _resolveArg: ((ResolverType, Any) -> Any)?
    private let _supports: (Any.Type, Any.Type) -> Bool

    init<T: FactoryType>(_ serviceFactory: T) {
        self._resolve = { resolver -> Any in
            serviceFactory.resolve(resolver)
        }
        self._resolveArg = { (resolver, a: Any) -> Any in
            serviceFactory.resolve(resolver, arg: a as! T.Arg)
        }
        self._supports = { $0 == T.ServiceType.self && $1 == T.Arg.self }
    }

    func resolve<ServiceType>(_ resolver: ResolverType) -> ServiceType {
        return _resolve!(resolver) as! ServiceType
    }
    
    func resolve<ServiceType, Arg>(_ resolver: ResolverType, arg: Arg) -> ServiceType {
        return _resolveArg!(resolver, arg) as! ServiceType
    }

    func supports<ServiceType>(_ type: ServiceType.Type) -> Bool {
        return _supports(type, Any.self)
    }
    
    func supports<ServiceType, Arg>(_ type: ServiceType.Type, argType: Arg.Type) -> Bool {
        return _supports(type, argType)
    }
}
