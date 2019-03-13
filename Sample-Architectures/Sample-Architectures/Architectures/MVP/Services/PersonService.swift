//
//  PersonService.swift
//  Sample-Architectures-MVP
//
//  Created by Ronaldo Gomes on 5/6/18.
//  Copyright © 2018 Technophile IT. All rights reserved.
//

import Foundation
import Moya
import Result

protocol PersonServiceDelegate: class {
    func loaded(_ people: [Person])
    func created(_ person: Person)
    func deleted(_ person: Person)
    func failed()
}

protocol PersonServicesProtocol {    
    var delegate: PersonServiceDelegate? { get set }
    func load()
    func create(_ person: Person)
    func delete(_ person: Person)
}

class PersonServices: PersonServicesProtocol {
    
    weak var delegate: PersonServiceDelegate?
    
    func load() {
        peopleMoyaProvider.request(.list) { result in
            switch result {
            case .success(let values):
                let people = try! JSONDecoder().decode([Person].self, from: values.data)
                self.delegate?.loaded(people)
            case .failure:
                self.delegate?.failed()
            }
        }
    }
    
    func create(_ person: Person) {
        peopleMoyaProvider.request(.create(person)) { result in
            switch result {
            case .success(let values):
                let person = try! JSONDecoder().decode(Person.self, from: values.data)
                self.delegate?.created(person)
            case .failure:
                self.delegate?.failed()
            }
        }
    }
    
    func delete(_ person: Person) {
        peopleMoyaProvider.request(.delete(person)) { result in
            switch result {
            case .success(let values):
                let person = try! JSONDecoder().decode(Person.self, from: values.data)
                self.delegate?.deleted(person)
            case .failure:
                self.delegate?.failed()
            }
        }
    }
    
}
