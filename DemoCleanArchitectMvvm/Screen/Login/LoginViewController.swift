//
//  LoginViewController.swift
//  DemoCleanArchitectMvvm
//
//  Created by Thanh Vu on 08/02/2023.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: BaseViewControler {
    var viewModel: LoginViewModel
    var coordinator: LoginCoordinator?

    // MARK: - Outlet
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var validateLabel: UILabel!
    
    // MARK: - Init
    init(viewModel: LoginViewModel, coordinator: LoginCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
    }

    // MARK: - Config
    func config() {
        configViewModelInput()
        configViewModelOutput()
        configRoutingOutput()
    }

    func configViewModelInput() {
        self.loginButton.rx.tap.throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(to: self.viewModel.input.loginPress)
            .disposed(by: self.viewModel.disposeBag)

        self.usernameTextField.rx.text.orEmpty.bind(to: self.viewModel.input.username)
            .disposed(by: self.disposeBag)
        self.passwordTextField.rx.text.orEmpty.bind(to: self.viewModel.input.password)
            .disposed(by: self.disposeBag)
    }

    func configViewModelOutput() {
        self.viewModel.output.validation
            .observe(on: MainScheduler.instance)
            .subscribe {[unowned self] validationMessage in
                self.validateLabel.text = validationMessage
            }
            .disposed(by: self.disposeBag)
    }

    func configRoutingOutput() {
        self.viewModel.routing.routeToMain
            .take(1)
            .subscribe(onNext: {[unowned self] _ in
                self.coordinator?.routeToMain()
            })
            .disposed(by: self.disposeBag)
    }
}
