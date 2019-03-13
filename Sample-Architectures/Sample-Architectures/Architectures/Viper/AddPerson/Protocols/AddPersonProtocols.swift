//
//  AddPersonProtocols.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 1/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import UIKit

protocol AddPersonViewProtocol: class {

    var presenter: AddPersonPresenterProtocol? { get set }
    
    func didCreatePerson()
    
}

protocol AddPersonWireFrameProtocol: class {
    
    static func createAddPersonFormModule(to segue:UIStoryboardSegue) -> UIViewController
    
}

protocol AddPersonInteractorInputProtocol: class {

    var presenter: AddPersonInteractorOutputProtocol? { get set }
    var remoteDataManager: AddPersonRemoteDataManagerInputProtocol? { get set }
//    var localDatamanager: ListPeopleLocalDataManagerInputProtocol? { get set }
    
    func save(person: Person)
    
}

protocol AddPersonInteractorOutputProtocol: class {
    
    func didSave(_ person: Person)
    
}

protocol AddPersonPresenterProtocol: AddPersonInteractorOutputProtocol {
 
    var view: AddPersonViewProtocol? { get set }
    var interactor:AddPersonInteractorInputProtocol?  { get set }
    var wireFrame: AddPersonWireFrameProtocol? { get set }
    
    func save(person: Person)
    
}

protocol AddPersonRemoteDataManagerInputProtocol: class {
    
    var handler: AddPersonRemoteDataManagerOutputProtocol? { get set }
    
    func save(person: Person)

}

protocol AddPersonRemoteDataManagerOutputProtocol: class {

    func didSave(person: Person)

}
