//
//  UserRepository.swift
//  DemoCleanArchitectMvvm
//
//  Created by Thanh Vu on 08/02/2023.
//

import UIKit
import RxSwift

public protocol UserRepository {
    func login(username: String, password: String) -> Observable<()>
}

public struct UserRepositoryInitParams {
}

final class UserRepositoryImpl: UserRepository {
    public init(params: UserRepositoryInitParams) {
    }

    func login(username: String, password: String) -> Observable<()> {
        // Example
        return Observable.just(())
    }
}
