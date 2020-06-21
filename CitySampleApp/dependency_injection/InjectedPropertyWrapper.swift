//
//  InjectedPropertyWrapper.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 19/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

@propertyWrapper
struct Injected<Service> {
    private var service: Service?
    private var arg: Any?
    
    init() { }
    
    init(_ arg: Any) {
        self.arg = arg
    }
    
    public var wrappedValue: Service {
        mutating get {
            if service == nil {
                if let arg = arg {
                    service = Resolver.root.resolve(Service.self, arg: arg)
                } else {
                    service = Resolver.root.resolve(Service.self)
                }
                
            }
            return service!
        }
        mutating set {
            service = newValue
        }
    }
    public var projectedValue: Injected<Service> {
        get {
            return self
        }
        mutating set {
            self = newValue
        }
    }
}
