//
//  Observable.swift
//  github-search-task
//
//  Created by inae Lee on 2021/10/25.
//

import Foundation

class Observable<T> {
    typealias Listener = ((T) -> Void)
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    /// @escaping을 붙여서 함수 밖에서도 전달받은 클로저가 저장, 실행될 수 있도록 함.
    func bind(closure: @escaping Listener) {
        listener = closure
        closure(value)
    }
}
