//
//  DIContainer.swift
//  SetTimer
//
//  Created by Manh Nguyen Ngoc on 02/07/2021.
//

import Foundation
import Resolver

public typealias DIInjected = Injected
public typealias DILazyInjected = LazyInjected
public typealias DIWeakLazyInjected = WeakLazyInjected
public typealias DIInjectedObject = InjectedObject
public typealias DIOptionalInjected = OptionalInjected

public class DIContainer {
    public static func registerDeps() {
        registerUsecases()
        registerRepos()
    }
    
    public static func resolve<Service>(_ serviceType: Service.Type) -> Service {
        return Resolver.resolve(serviceType)
    }
    
    public static func resolve<Service>() -> Service {
        return Resolver.resolve(Service.self)
    }
    
    public static func resolve<Service, Arg1>(_ serviceType: Service.Type, agrument: Arg1) -> Service {
        return Resolver.resolve(serviceType, args: agrument)
    }
    
    public static func register<Service>(_ serviceType: Service.Type, _ factory: @escaping ResolverFactoryArgumentsN<Service>) {
        Resolver.register(factory: factory)
    }
}
