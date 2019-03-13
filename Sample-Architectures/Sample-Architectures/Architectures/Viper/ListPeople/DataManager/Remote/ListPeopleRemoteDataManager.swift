//
// Created by VIPER
// Copyright (c) 2016 VIPER. All rights reserved.
//

import Foundation

class ListPeopleRemoteDataManager: ListPeopleRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: ListPeopleRemoteDataManagerOutputProtocol?
    
    init() {}
    
    func retrivePeopleList() {
        if let remoteRequestHandler = self.remoteRequestHandler {
            AppDelegate.dataStore.fetch(remoteRequestHandler.onRetrievePeople)
        }        
    }
    
    func remove(_ person:Person) {
        if let remoteRequestHandler = self.remoteRequestHandler {
            try! AppDelegate.dataStore.delete(person, completionHandler: remoteRequestHandler.didRemovePerson)
        }        
    }
    
}
