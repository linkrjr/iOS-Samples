//
//  Example3ViewModel.swift
//  Sample-RxSwift
//
//  Created by Ronaldo GomesJr on 7/03/2016.
//  Copyright © 2016 it.technophile. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class Example3ViewModel {

    var validatedUsername: Driver<ValidationResult>!
    var validatedPassword: Driver<ValidationResult>!
    var username:Driver<String>!
    
    var signedIn: Driver<Bool> = Driver.just(false)
    
    var signupEnabled: Driver<Bool>
    
    var signingIn: Driver<Bool>
    
    init(input: (
        username: Driver<String>,
        password: Driver<String>,
        loginTaps: Driver<Void>
        )) {
    
        self.validatedUsername = input.username.flatMapLatest { username in
            return Validator.validateUsername(username).asDriver(onErrorJustReturn: ValidationResult.Failed(message: "failed"))
        }

        self.validatedPassword = input.username.flatMapLatest { username in
            return Driver.just(ValidationResult.OK(message: "valid password"))
        }
            
        let signingIn = ActivityIndicator()
        self.signingIn = signingIn.asDriver()
            
        let usernameAndPassword = Driver.combineLatest(input.username, input.password) {
            ($0, $1)
        }
            
        self.signedIn = input.loginTaps.withLatestFrom(usernameAndPassword).flatMapLatest({ (username, password) in
            return API.signup(username, password: password).trackActivity(signingIn).asDriver(onErrorJustReturn: false)
        }).flatMapLatest({ loggedIn -> Driver<Bool> in
            let message = loggedIn ? "Success" : "Failed"
            return DefaultWireframe.sharedInstance.promptFor(message, cancelAction: "Ok", actions: []).map { _ in
                loggedIn
            }.asDriver(onErrorJustReturn: false)
        })
        
        self.signupEnabled = Driver.combineLatest(
            self.validatedUsername,
            self.validatedPassword) { username, _  in
            
            return username.isValid
                
        }.distinctUntilChanged()
    
    }
    
}
