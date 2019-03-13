//
//  ActivityIndicator.swift
//  Sample-RxSwift
//
//  Created by Ronaldo GomesJr on 8/03/2016.
//  Copyright © 2016 it.technophile. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ActivityToken<E> : ObservableConvertibleType, Disposable {
    private let _source: Observable<E>
    private let _dispose: AnonymousDisposable
    
    init(source: Observable<E>, disposeAction: () -> ()) {
        _source = source
        _dispose = AnonymousDisposable(disposeAction)
    }
    
    func dispose() {
        _dispose.dispose()
    }
    
    func asObservable() -> Observable<E> {
        return _source
    }
}

/**
 Enables monitoring of sequence computation.
 
 If there is at least one sequence computation in progress, `true` will be sent.
 When all activities complete `false` will be sent.
 */
class ActivityIndicator : DriverConvertibleType {
    typealias E = Bool
    
    private let _lock = NSRecursiveLock()
    private let _variable = Variable(0)
    private let _loading: Driver<Bool>
    
    init() {
        _loading = _variable.asObservable()
            .map { $0 > 0 }
            .distinctUntilChanged()
            .asDriver { (error: ErrorType) -> Driver<Bool> in
                _ = fatalError("Loader can't fail")
                return Driver.empty()
        }
    }
    
    func trackActivity<O: ObservableConvertibleType>(source: O) -> Observable<O.E> {
        return Observable.using({ () -> ActivityToken<O.E> in
            self.increment()
            return ActivityToken(source: source.asObservable(), disposeAction: self.decrement)
            }) { t in
                return t.asObservable()
        }
    }
    
    private func increment() {
        _lock.lock()
        _variable.value = _variable.value + 1
        _lock.unlock()
    }
    
    private func decrement() {
        _lock.lock()
        _variable.value = _variable.value - 1
        _lock.unlock()
    }
    
    func asDriver() -> Driver<E> {
        return _loading
    }
}

extension ObservableConvertibleType {
    func trackActivity(activityIndicator: ActivityIndicator) -> Observable<E> {
        return activityIndicator.trackActivity(self)
    }
}