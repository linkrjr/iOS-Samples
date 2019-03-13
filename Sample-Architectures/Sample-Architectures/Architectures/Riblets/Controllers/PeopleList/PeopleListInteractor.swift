//
//  PeopleListInteractor.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 28/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation

protocol PeopleListInteractorOutput {
    func presentPeople(_ people: [Person])
}

class PeopleListInteractor: Interactor, PeopleListPresenterOutput {

    var interactorOutput: PeopleListInteractorOutput?    
    var router: PeopleListRouter?    
    
    func fetchAllPeople() {
        AppDelegate.dataStore.fetch { people in
            self.interactorOutput?.presentPeople(people)
        }        
    }
    
    func showDetails(for person: Person) {
                
        self.router?.attachView(routeType: .show)
        
    }
    
}
