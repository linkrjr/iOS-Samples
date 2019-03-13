//
// Created by VIPER
// Copyright (c) 2016 VIPER. All rights reserved.
//

import Foundation
import UIKit

class ListPeoplePresenter: ListPeoplePresenterProtocol {
    weak var view: ListPeopleViewProtocol?
    var interactor: ListPeopleInteractorInputProtocol?
    var wireFrame: ListPeopleWireFrameProtocol?
    
    init() {}
    
    func viewDidLoad() {
    }
    
    func viewWillAppear() {
        self.view?.showLoading()
        self.reloadPeopleList()
    }
    
    func reloadPeopleList() {
        self.interactor?.fetchPeole()
    }
    
    func showPersonDetail(for person:Person, to segue:UIStoryboardSegue) {
        self.wireFrame?.presentPersonDetailScreen(from: self.view!, for: person, to: segue)
    }
    
    func showAddPersonForm(to segue:UIStoryboardSegue) {
        self.wireFrame?.presentAddPersonFormScreen(from: self.view!, to: segue)
    }
    
    func remove(_ person: Person) {
        self.interactor?.remove(person)
    }
    
}

extension ListPeoplePresenter: ListPeopleInteractorOutputProtocol {
    
    func didRemovePerson() {
        self.view?.didRemovePerson()
    }

    func didRetrivePeople(_ people: [Person]) {
        
        self.view?.hideLoading()
        self.view?.showPeople(people)
        
    }
    
}
