//
//  UserInfoUseCase.swift
//  DemoCleanArchitectMvvm
//
//  Created by Thanh Vu on 08/02/2023.
//

import UIKit
import RxSwift

public protocol UserInfoUsecase {
    func execute() -> Observable<()>
}

final class UserInfoUsecaseImpl: UserInfoUsecase {
    public init() {
    }
    
    public func execute() -> Observable<()> {
        fatalError()
    }
}
