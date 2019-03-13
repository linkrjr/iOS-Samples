//
//  AddPersonRemoteDataManager.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 2/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation

class AddPersonRemoteDataManager: AddPersonRemoteDataManagerInputProtocol {

    var handler: AddPersonRemoteDataManagerOutputProtocol?
    
    func save(person: Person) {
    
        try! AppDelegate.dataStore.create(person) {
            self.handler?.didSave(person: person)
        }
    
    }
    
}
