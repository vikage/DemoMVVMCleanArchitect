//  PresentedCoordinator.swift

import Foundation
import UIKit

open class PresentedCoordinator: Coordinator {
    var presentingViewController: UIViewController

    public init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
}
