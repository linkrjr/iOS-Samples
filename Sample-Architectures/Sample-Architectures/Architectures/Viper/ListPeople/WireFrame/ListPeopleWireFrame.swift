//
// Created by VIPER
// Copyright (c) 2016 VIPER. All rights reserved.
//

import Foundation
import UIKit

class ListPeopleWireFrame: ListPeopleWireFrameProtocol {

    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "main", bundle: Bundle.main)
    }
    
    class func createListPeople() -> UIViewController {
        
        if let navigationController = mainStoryboard.instantiateViewController(withIdentifier: "NavigationController") as? UINavigationController,
            let viewController = navigationController.childViewControllers.first as? ListPeopleViewController {
            
            let presenter: ListPeoplePresenterProtocol & ListPeopleInteractorOutputProtocol = ListPeoplePresenter()
            let interactor: ListPeopleInteractorInputProtocol & ListPeopleRemoteDataManagerOutputProtocol = ListPeopleInteractor()
            let remoteDataManager: ListPeopleRemoteDataManagerInputProtocol = ListPeopleRemoteDataManager()
            let wireFrame: ListPeopleWireFrameProtocol = ListPeopleWireFrame()
            
            viewController.presenter = presenter
            presenter.view = viewController
            presenter.interactor = interactor
            presenter.wireFrame = wireFrame
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navigationController
        }
        
        return UIViewController()
    }
    
    func presentPersonDetailScreen(from view: ListPeopleViewProtocol, for person: Person, to segue:UIStoryboardSegue) {
        PersonDetailWireFrame.createPersonDetailModule(for: person, to: segue)
    }
    
    func presentAddPersonFormScreen(from view: ListPeopleViewProtocol, to segue: UIStoryboardSegue) {
        AddPersonWireFrame.createAddPersonFormModule(to: segue)
    }

}
