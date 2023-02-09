//
//  LoginViewModel.swift
//  DemoCleanArchitectMvvm
//
//  Created by Thanh Vu on 08/02/2023.
//

import UIKit
import RxSwift

struct LoginViewModelInput: InputOutputViewModel {
    let username = PublishSubject<String>()
    let password = PublishSubject<String>()
    let loginPress = PublishSubject<()>()
}

struct LoginViewModelOutput: InputOutputViewModel {
    fileprivate(set) var validation: Observable<String>!
    fileprivate(set) var loginError = PublishSubject<Error>()
}

struct LoginViewModelRouting: RoutingOutput {
    fileprivate(set) var routeToMain = PublishSubject<()>()
}

final class LoginViewModel: BaseViewModel<LoginViewModelInput, LoginViewModelOutput, LoginViewModelRouting> {
    @DILazyInjected private var loginUsecase: LoginUsecase

    override init() {
        super.init()
        configOutput()
    }

    private func configOutput() {
        let combineUsernameAndPasswordObservable = Observable.combineLatest(self.input.username, self.input.password).share()
        self.output.validation = combineUsernameAndPasswordObservable
            .observe(on: MainScheduler.instance)
            .map({ username, password in
                // TODO: Do validation
                return !username.isEmpty && !password.isEmpty
            })
            .map({ isValid in
                return isValid ? "" : "Username and password must not empty"
            })

        self.input.loginPress
            .withLatestFrom(combineUsernameAndPasswordObservable)
            .flatMapLatest({[unowned self] username, password in
                return self.loginUsecase.execute(username: username, password: password)
            })
            .subscribe(onNext: {[unowned self] _ in
                // Login success
                self.routing.routeToMain.onNext(())
            }, onError: { error in
                self.output.loginError.onNext(error)
            })
            .disposed(by: disposeBag)
    }
}
