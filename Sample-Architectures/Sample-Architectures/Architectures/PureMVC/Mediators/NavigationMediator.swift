//
//  NavigationMediator.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 4/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import puremvc
import UIKit

class NavigationMediator: Mediator {

    open override class func name() -> String! { return "NavigationMediator" }
    
    init(viewComponent: NavigationController) {
        super.init(mediatorName: NavigationMediator.name(), viewComponent: viewComponent)
    }
    
    override func onRegister() {
        navigationController.mediator = self
    }
    
    func viewDidLoad() {
        
        facade.register(ListPeopleMediator(viewComponent: navigationController.peopleList))
        facade.register(AddPersonMediator(viewComponent: navigationController.personForm))
        
    }
    
    override func listNotificationInterests() -> [Any]! {
        return [
            ApplicationFacade.PERSON_SELECTED,
            ApplicationFacade.NEW_PERSON
        ]
    }
    
    override func handle(_ notification: INotification) {
        switch notification.name() {
        case ApplicationFacade.PERSON_SELECTED: self.navigationController.showPersonDetails(notification.body() as! Person)
        case ApplicationFacade.NEW_PERSON: self.navigationController.showPersonForm()
        default: break
        }
    }
    
    var navigationController: NavigationController {
        return viewComponent as! NavigationController
    }    
    
}
