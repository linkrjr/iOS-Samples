//
//  PeopleListPresenter.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 28/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation

protocol PeopleListPresenterOutput {
    func fetchAllPeople()
    func showDetails(for person: Person)
}

protocol PeopleListViewOutput {
    func getPeople()
    func showDetails(for person: Person)
}

class PeopleListPresenter: PeopleListInteractorOutput, PeopleListViewOutput {

    var presenterOutput: PeopleListPresenterOutput?
    var viewInput: PeopleListViewInput?

    //MARK: - PeopleListViewOutput
    
    func getPeople() {
        self.presenterOutput?.fetchAllPeople()
    }
    
    func showDetails(for person: Person) {
        self.presenterOutput?.showDetails(for: person)
    }
    
    //MARK: - PeopleListInteractorOutput
    
    func presentPeople(_ people: [Person]) {
        self.viewInput?.displayPeople(people)
    }

}
