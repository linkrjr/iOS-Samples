//
//  Router.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 28/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import UIKit

struct Context: Hashable, Equatable {
    
    var hashValue: Int
    
    static func ==(lhs: Context, rhs: Context) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
}

class RibletRouter {

    var riblet: Riblet?
    var childRiblets: [Context : Riblet] = [:]
    
    func addChild(_ riblet: Riblet, to context: Context) {
        self.childRiblets[context] = riblet
    }

    func removeChild(context: Context) {
        if self.childRiblets[context] != nil { self.childRiblets[context] = nil }
    }
    
    func childRiblet(for context: Context) -> Riblet? {
        return self.childRiblets[context]
    }
    
}
