//  BaseNavigationController.swift

import Foundation
import UIKit

open class BaseNavigationController: UINavigationController {
    private weak var topViewControllerBeforeGestureStart: UIViewController?

    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

        self.modalPresentationStyle = .fullScreen
        self.navigationBar.isHidden = true
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.modalPresentationStyle = .fullScreen
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        self.interactivePopGestureRecognizer?.isEnabled = true
        self.interactivePopGestureRecognizer?.delegate = self
        self.interactivePopGestureRecognizer?.addTarget(self, action: #selector(interactivePopGestureUpdate(_:)))
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.topViewController?.preferredStatusBarStyle ?? .default
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.topViewController?.supportedInterfaceOrientations ?? .portrait
    }

    open override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool = true, completion: (() -> Void)? = nil) {
        if viewControllerToPresent is UINavigationController {
            super.present(viewControllerToPresent, animated: flag, completion: completion)
        } else {
            let navigationController = BaseNavigationController(rootViewController: viewControllerToPresent)
            navigationController.modalPresentationStyle = viewControllerToPresent.modalPresentationStyle
            super.present(navigationController, animated: flag, completion: completion)
        }
    }

    public func pushWithPresentAnimation(viewController: UIViewController) {
                let transition = CATransition()
        transition.duration = 0.25
        transition.type = .moveIn
        transition.subtype = .fromTop
        transition.timingFunction = CAMediaTimingFunction(name: .easeOut)

        self.view.layer.add(transition, forKey: kCATransition)
        self.pushViewController(viewController, animated: false)
    }

    @objc func interactivePopGestureUpdate(_ gesture: UIGestureRecognizer) {
        if gesture.state == .began,
            let coordinator = self.topViewController?.transitionCoordinator {
            coordinator.notifyWhenInteractionChanges { context in
                if !context.isCancelled,
                    let topVC = self.topViewControllerBeforeGestureStart as? BaseViewControler {
                    topVC.viewWillDisappearByInteractive()
                }

                self.topViewControllerBeforeGestureStart = nil
            }
        }
    }
}

extension BaseNavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            self.topViewControllerBeforeGestureStart = self.topViewController
            return self.viewControllers.count > 1
        }

        return true
    }
}
