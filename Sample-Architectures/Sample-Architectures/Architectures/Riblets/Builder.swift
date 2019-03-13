//
//  Builder.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 28/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation

protocol BuilderProtocol {
    func build() -> Riblet
}

class Builder: BuilderProtocol {

    func build() -> Riblet {        
        abort()
    }
    
    func build(parentInteractor : Interactor) -> Riblet {
        abort()
    }
    
}
