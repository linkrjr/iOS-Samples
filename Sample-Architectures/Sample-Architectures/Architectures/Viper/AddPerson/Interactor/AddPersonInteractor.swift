//
//  AddPersonInteractor.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 2/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation

class AddPersonInteractor: AddPersonInteractorInputProtocol {

    var presenter: AddPersonInteractorOutputProtocol?
    var remoteDataManager: AddPersonRemoteDataManagerInputProtocol?
    
    func save(person: Person) {
        
        self.remoteDataManager?.save(person: person)
        
    }
    
}

extension AddPersonInteractor: AddPersonRemoteDataManagerOutputProtocol {

    func didSave(person: Person) {
        self.presenter?.didSave(person)
    }
    
}
