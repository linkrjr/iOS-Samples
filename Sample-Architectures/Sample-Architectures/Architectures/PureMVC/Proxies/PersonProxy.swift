//
//  PersonProxy.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 4/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import puremvc

class PersonProxy: Proxy {

    open override class func name() -> String! { return "PersonProxy" }
    
    override init() {
        super.init(proxyName: PersonProxy.name(), data: [Person]())
    }
    
    var people:[Person] {
        return data as! [Person]
    }
    
    func delete(_ person: Person) {
        var people = data as! [Person]
        for (index, element) in self.people.enumerated() {
            if element == person {
                people.remove(at: index)
                self.data = people
                break
            }
        }
    }
    
    func add(_ person: Person) {
        var people = data as! [Person]
        people.append(person)
        data = people
    }
    
}
