//
//  AddPersonViewModel.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 27/07/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import Foundation

protocol AddPersonPresenterProtocol {    
    func createPerson(_ person:Person)
}

protocol AddPersonViewPort {
    func didCreate(_ person: Person)
}

class AddPersonPresenter: AddPersonPresenterProtocol {

    fileprivate let services: PersonServicesProtocol!
    fileprivate var viewPort: AddPersonViewPort?
    
    init(services: PersonServicesProtocol = PersonServices()) {
        self.services = services
        self.services.delegate = self
    }
    
    func createPerson(_ person:Person) {
        services.create(person)
    }
    
}

extension AddPersonPresenter: PersonServiceDelegate {
    
    func loaded(_ people: [Person]) {
        fatalError("Need a way to not required this method here!!!")
    }
    
    func created(_ person: Person) {
        self.viewPort?.didCreate(person)
    }
    
    func deleted(_ person: Person) {
        fatalError("Need a way to not required this method here!!!")
    }

    func failed() {
        fatalError("Should handle errors!!!")
    }
    
}
