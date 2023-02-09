//  BaseViewController.swift

import Foundation
import UIKit
import RxSwift

open class BaseViewControler: UIViewController {
    private(set) var viewWillAppeared: Bool = false
    private(set) var viewDidAppeared: Bool = false
    public var isDisplaying: Bool = false
    private(set) var disposeBag = DisposeBag()
    
    // MARK: - Life cycle
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !viewWillAppeared {
            viewWillAppeared = true
            self.viewWillFirstAppear()
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isDisplaying = true
        if !viewDidAppeared {
            viewDidAppeared = true
            self.viewDidFirstAppear()
        }
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isDisplaying = false
    }
    
    open func viewWillFirstAppear() {
        // nothing
    }
    
    open func viewDidFirstAppear() {
        // nothing
    }

    open func viewWillDisappearByInteractive() {
        // nothing
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
