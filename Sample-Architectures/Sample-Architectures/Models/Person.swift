//
//  Person.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 4/04/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import Foundation


struct Person: Codable, Equatable {
    var name: String
    var email: String
    var age: Int
//    var archived:Bool = false
    
    var nameAndAge: String {
        return "\(self.name) (\(self.age))"
    }
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.email == rhs.email
    }
}
