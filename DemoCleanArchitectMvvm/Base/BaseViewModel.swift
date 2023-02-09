//  BaseViewModel.swift

import Foundation
import RxSwift

public protocol InputOutputViewModel {
    init()
}

public protocol RoutingOutput {
    init()
}

public class BaseViewModel<Input: InputOutputViewModel, Output: InputOutputViewModel, Routing: RoutingOutput> {
    var input = Input()
    var output = Output()
    var routing = Routing()
    var disposeBag = DisposeBag()
}
