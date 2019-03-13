//: Playground - noun: a place where people can play

import RxSwift
import RxCocoa

var ob1 = Observable.just(1,2,3)

ob1.subscribeNext { v in
    print("number: \(v)")
}.addDisposableTo(DisposeBag())


let booleans = [
    false,
    true
]


let allTrue = booleans.reduce(true) { (sum, next) in
    return sum && next
}

let allFalse = booleans.reduce(true) { (sum, next) in
    return sum && !next
}

let anyTrue = booleans.reduce(false) { (sum, next) in
    return sum || next
}
