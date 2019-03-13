//
//  ShowPersonPresenter.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 27/07/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import Foundation

protocol ShowPersonPresenterProtocol: class {
    
    var person:Person? { get }
    
    init(person:Person)
    
}

class ShowPersonPresenter: ShowPersonPresenterProtocol {

    var person:Person?
    
    var nameText:String {
        if let person = self.person {
            return person.name
        }
        return ""
    }

    var emailText:String {
        if let person = self.person {
            return person.email
        }
        return ""
    }

    var ageText:String {
        if let person = self.person {
            return "\(person.age)"
        }
        return ""
    }
    
    required init(person:Person) {
        self.person = person
    }
    
}
