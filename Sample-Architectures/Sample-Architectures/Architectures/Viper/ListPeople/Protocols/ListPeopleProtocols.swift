//
// Created by VIPER
// Copyright (c) 2016 VIPER. All rights reserved.
//

import Foundation
import UIKit

//Mark: ViewController

protocol ListPeopleViewProtocol: class {
    var presenter: ListPeoplePresenterProtocol? { get set }
    
    func showLoading()
    func hideLoading()
    
    func showPeople(_ people: [Person])
    func didRemovePerson()
}

//Mark: Wireframe

protocol ListPeopleWireFrameProtocol: class {
    func presentPersonDetailScreen(from view: ListPeopleViewProtocol, for person: Person, to segue: UIStoryboardSegue)
    func presentAddPersonFormScreen(from view: ListPeopleViewProtocol, to segue: UIStoryboardSegue)
    static func createListPeople() -> UIViewController
}

//Mark: Presenter

protocol ListPeoplePresenterProtocol: class {
    var view: ListPeopleViewProtocol? { get set }
    var interactor: ListPeopleInteractorInputProtocol? { get set }
    var wireFrame: ListPeopleWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func reloadPeopleList()
    func showPersonDetail(for person:Person, to segue:UIStoryboardSegue)
    func showAddPersonForm(to segue:UIStoryboardSegue)
    
    func remove(_ person: Person)
    
}

protocol ListPeopleInteractorOutputProtocol: class {
    
    func didRetrivePeople(_ people: [Person])
    
    func didRemovePerson()
    
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

//MARK: Interactor

protocol ListPeopleInteractorInputProtocol: class {
    var presenter: ListPeopleInteractorOutputProtocol? { get set }
    var remoteDataManager: ListPeopleRemoteDataManagerInputProtocol? { get set }
    var localDatamanager: ListPeopleLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func fetchPeole()
    func remove(_ person: Person)
}

//protocol ListPeopleDataManagerInputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
//}

protocol ListPeopleRemoteDataManagerOutputProtocol: class {
    func onRetrievePeople(_ posts: [Person])
    func didRemovePerson()
    func onError()    
}

//Mark: DataManager

protocol ListPeopleRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ListPeopleRemoteDataManagerOutputProtocol? { get set }
    
    func retrivePeopleList()
    func remove(_ person:Person)    
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
}

protocol ListPeopleLocalDataManagerInputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
}
