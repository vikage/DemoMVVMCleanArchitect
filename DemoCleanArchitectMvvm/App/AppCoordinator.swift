//
//  AppCoordinator.swift
//  DemoCleanArchitectMvvm
//
//  Created by Thanh Vu on 08/02/2023.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    private var window: UIWindow
    private var loginCoordinator: LoginCoordinator?

    init(window: UIWindow) {
        self.window = window
        super.init()
        self.routeToLogin()
    }

    override func handle(event: CoordinatorEvent) -> Bool {
        if event is LoginSuccessEvent {
            if let loginCoordinator {
                self.removeChild(loginCoordinator)
                self.loginCoordinator?.stop()
                self.loginCoordinator = nil
            }

            self.routeToMain()
        }

        return false
    }

    // MARK: - Routing
    func routeToLogin() {
        let loginCoordinator = LoginCoordinator(window: self.window)
        loginCoordinator.start()
        self.addChild(loginCoordinator)
        self.loginCoordinator = loginCoordinator
    }

    func routeToMain() {
        if let loginCoordinator {
            loginCoordinator.stop()
            self.loginCoordinator = nil
        }

        let mainCoordinator = MainCoordinator(window: self.window)
        mainCoordinator.start()
        self.addChild(mainCoordinator)
    }
}
