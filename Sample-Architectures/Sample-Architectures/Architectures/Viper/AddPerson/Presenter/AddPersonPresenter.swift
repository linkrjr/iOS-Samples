//
//  AddPersonPresenter.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 2/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation

class AddPersonPresenter: AddPersonPresenterProtocol {

    var view: AddPersonViewProtocol?
    var interactor:AddPersonInteractorInputProtocol?
    var wireFrame: AddPersonWireFrameProtocol?
    
    func save(person: Person) {
        self.interactor?.save(person: person)        
    }
    
}

extension AddPersonPresenter: AddPersonInteractorOutputProtocol {

    func didSave(_ person: Person) {
        self.view?.didCreatePerson()
    }

}
