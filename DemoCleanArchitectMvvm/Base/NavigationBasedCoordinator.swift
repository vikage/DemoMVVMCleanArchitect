//  NavigationBasedCoordinator.swift

import Foundation
import UIKit

open class NavigationBasedCoordinator: Coordinator {
    var navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
}
