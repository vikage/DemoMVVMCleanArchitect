//
//  MainCoordinator.swift
//  DemoCleanArchitectMvvm
//
//  Created by Thanh Vu on 08/02/2023.
//

import UIKit

final class MainCoordinator: Coordinator {
    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init()
    }
    
    lazy var controller: MainViewController = {
        let viewModel = MainViewModel()
        let controller = MainViewController(viewModel: viewModel, coordinator: self)
        return controller
    }()

    override func start() {
        super.start()

        self.window.rootViewController = self.controller
        self.window.makeKeyAndVisible()
    }

    override func stop(completion: (() -> Void)? = nil) {
        super.stop(completion: completion)
    }
}
