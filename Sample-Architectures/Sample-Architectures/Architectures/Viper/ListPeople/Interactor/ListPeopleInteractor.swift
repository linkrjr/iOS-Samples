//
// Created by VIPER
// Copyright (c) 2016 VIPER. All rights reserved.
//

import Foundation

class ListPeopleInteractor: ListPeopleInteractorInputProtocol {
    
    weak var presenter: ListPeopleInteractorOutputProtocol?
    var remoteDataManager: ListPeopleRemoteDataManagerInputProtocol?
    var localDatamanager: ListPeopleLocalDataManagerInputProtocol?
    
    init() {}
    
    func fetchPeole() {
        self.remoteDataManager?.retrivePeopleList()
    }
    
    func remove(_ person: Person) {
        self.remoteDataManager?.remove(person)
    }
    
}

extension ListPeopleInteractor: ListPeopleRemoteDataManagerOutputProtocol {
    
    func onRetrievePeople(_ people: [Person]) {
        
        self.presenter?.didRetrivePeople(people)
        
    }
    
    func onError() {
        
    }
    
    func didRemovePerson() {
        self.presenter?.didRemovePerson()
    }
    
}
