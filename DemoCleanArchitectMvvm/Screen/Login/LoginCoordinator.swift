//
//  LoginCoordinator.swift
//  DemoCleanArchitectMvvm
//
//  Created by Thanh Vu on 08/02/2023.
//

import UIKit

struct LoginSuccessEvent: CoordinatorEvent {
}

final class LoginCoordinator: Coordinator {
    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init()
    }
    
    lazy var controller: LoginViewController = {
        let viewModel = LoginViewModel()
        let controller = LoginViewController(viewModel: viewModel, coordinator: self)
        return controller
    }()

    override func start() {
        super.start()

        self.window.rootViewController = self.controller
        self.window.makeKeyAndVisible()
    }

    func routeToMain() {
        self.send(event: LoginSuccessEvent())
    }

    override func stop(completion: (() -> Void)? = nil) {
        if self.window.rootViewController == self {
            self.window.rootViewController = nil
        }

        super.stop(completion: completion)
    }
}
