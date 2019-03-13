//
//  Riblet.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 28/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import UIKit

class Riblet: Equatable {

    var router: RibletRouter
    var interactor: Interactor
    var builder: Builder
    
    var viewController: UIViewController?
    
    init(router: RibletRouter, interactor: Interactor, builder: Builder) {
    
        self.router = router
        self.interactor = interactor
        self.builder = builder
        
    }    
    
    static func ==(lhs: Riblet, rhs: Riblet) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
}
