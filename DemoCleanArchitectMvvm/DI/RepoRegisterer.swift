//
//  RepoRegisterer.swift
//  DemoCleanArchitectMvvm
//
//  Created by Thanh Vu on 08/02/2023.
//

import Foundation

func registerRepos() {
    DIContainer.register(UserRepository.self) { resolver, args in
        return UserRepositoryImpl(params: UserRepositoryInitParams())
    }
}
