//
//  AddPersonWireFrame.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 1/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import UIKit

class AddPersonWireFrame: AddPersonWireFrameProtocol {

    @discardableResult
    static func createAddPersonFormModule(to segue:UIStoryboardSegue) -> UIViewController {

        let navigationViewController = segue.destination as! UINavigationController
        let viewController = navigationViewController.childViewControllers.first as! AddPersonViewController
//        addPersonViewController.delegate = self
        
        let presenter: AddPersonPresenterProtocol = AddPersonPresenter()
        let interactor: AddPersonInteractorInputProtocol & AddPersonRemoteDataManagerOutputProtocol = AddPersonInteractor()
        let remoteDataManager: AddPersonRemoteDataManagerInputProtocol = AddPersonRemoteDataManager()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        remoteDataManager.handler = interactor
        
        return navigationViewController
    }

}
