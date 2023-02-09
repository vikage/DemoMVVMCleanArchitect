//
//  UsecaseRegisterer.swift
//  DemoCleanArchitectMvvm
//
//  Created by Thanh Vu on 08/02/2023.
//

import Foundation

func registerUsecases() {
    DIContainer.register(LoginUsecase.self) { _, _ in
        return LoginUsecaseImpl()
    }

    DIContainer.register(UserInfoUsecase.self) { resolver, args in
        return UserInfoUsecaseImpl()
    }
}
