//
//  ListPeoplePresenter.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 4/04/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import Foundation

protocol ListPeopleViewPort: class {
    func loaded()
}

class ListPeoplePresenter {
    
    fileprivate var services: PersonServicesProtocol
    fileprivate var viewPort: ListPeopleViewPort?
    
    var people:[Person] = []
    
    var count:Int {
        return self.people.count
    }

    required init(viewPort: ListPeopleViewPort, services: PersonServicesProtocol = PersonServices()) {
        self.viewPort = viewPort
        self.services = services
        self.services.delegate = self
        self.loadPeople()
    }
    
    func nameAndAgeForIndexPath(_ indexPath:IndexPath) -> String {
        let person = self.fetchPersonByIndexPath(indexPath)
        return "-> \(person.name) (\(person.age))"
    }
    
    func loadPeople() {
        self.services.load()
    }
 
    func fetchPersonByIndexPath(_ indexPath:IndexPath) -> Person {
        return self.people[indexPath.row]
    }
    
    func removePersonAt(IndexPath indexPath: IndexPath) {
        let person = self.fetchPersonByIndexPath(indexPath)
        self.services.delete(person)
    }
    
}

extension ListPeoplePresenter: PersonServiceDelegate {
    
    func loaded(_ people: [Person]) {
        self.people = people
        self.viewPort?.loaded()
    }
    
    func created(_ person: Person) {
        fatalError("Need a way to not required this method here!!!")
    }
    
    func deleted(_ person: Person) {
        self.loadPeople()
    }
    
    func failed() {
        fatalError("Should handle errors!!!")
    }
    
}
