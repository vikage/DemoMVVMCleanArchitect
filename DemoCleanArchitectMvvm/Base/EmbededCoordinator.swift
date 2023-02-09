//  EmbededCoordinator.swift

import Foundation
import UIKit

class EmbededCoordinator: Coordinator {
    private(set) var contentView: UIView
    private(set) var viewController: UIViewController

    init(contentView: UIView, viewController: UIViewController) {
        self.contentView = contentView
        self.viewController = viewController
    }

    override func start() {
        if self.started {
            return
        }

        super.start()
        self.contentView.addSubview(self.viewController.view)
        NSLayoutConstraint.activate([
            self.viewController.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.viewController.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.viewController.view.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.viewController.view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }

    override func stop(completion: (() -> Void)? = nil) {
        super.stop(completion: completion)

        self.viewController.view.removeFromSuperview()
        self.viewController.removeFromParent()
    }
}
