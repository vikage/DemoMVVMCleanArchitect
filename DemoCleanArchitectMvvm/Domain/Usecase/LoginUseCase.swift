//
//  LoginUseCase.swift
//  DemoCleanArchitectMvvm
//
//  Created by Thanh Vu on 08/02/2023.
//

import UIKit
import RxSwift

public protocol LoginUsecase {
    func execute(username: String, password: String) -> Observable<()>
}

final class LoginUsecaseImpl: LoginUsecase {
    @DIInjected private var userRepo: UserRepository

    public init() {
    }
    
    public func execute(username: String, password: String) -> Observable<()> {
        return userRepo.login(username: username, password: password)
    }
}
