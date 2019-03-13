//
//  ListPeopleMediator.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 4/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import puremvc

class ListPeopleMediator: Mediator {

    open override class func name() -> String! { return "ListPeopleMediator" }
    
    var listPeopleViewController: ListPeopleViewController {
        return viewComponent as! ListPeopleViewController
    }
    
    init(viewComponent: ListPeopleViewController) {
        super.init(mediatorName: ListPeopleMediator.name(), viewComponent: viewComponent)
    }

    override func onRegister() {
        self.listPeopleViewController.mediator = self
    }
    
    func viewDidLoad() {
        self.load()
    }
    
    func onDelete(_ person: Person) {
        sendNotification(ApplicationFacade.DELETE_PERSON, body: person)
    }
    
    func onSelect(_ person: Person) {
        sendNotification(ApplicationFacade.PERSON_SELECTED, body: person)
    }
    
    func onNew() {
        sendNotification(ApplicationFacade.NEW_PERSON)
    }
    
    override func listNotificationInterests() -> [Any]! {
        return [
            ApplicationFacade.PERSON_ADDED
        ]
    }
    
    override func handle(_ notification: INotification) {
        switch notification.name() {
        case ApplicationFacade.PERSON_ADDED:
            self.load()
            self.listPeopleViewController.reload()
        default: break
        }
    }
    
    private func load() {
        if let personProxy = facade.retrieveProxy(PersonProxy.name()) as? PersonProxy {
            self.listPeopleViewController.people = personProxy.people
        }
    }

}
