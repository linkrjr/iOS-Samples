//
//  AddPersonMediator.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 7/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import puremvc

class AddPersonMediator: Mediator {

    open override class func name() -> String! { return "AddPersonMediator" }
    
    var addPersonViewController: AddPersonViewController {
        return viewComponent as! AddPersonViewController
    }
    
    init(viewComponent: AddPersonViewController) {
        super.init(mediatorName: AddPersonMediator.name(), viewComponent: viewComponent)
    }
    
    func viewDidLoad() {}
    
    func viewWillAppear(_ animated: Bool) {
        self.addPersonViewController.resetForm()
    }
    
    override func onRegister() {
        self.addPersonViewController.mediator = self
    }
    
    func onCreate(_ person: Person) {
        sendNotification(ApplicationFacade.CREATE_PERSON, body: person)
    }
    
    override func listNotificationInterests() -> [Any]! {
        return [
            ApplicationFacade.PERSON_ADDED
        ]
    }
    
    override func handle(_ notification: INotification) {
        switch notification.name() {
        case ApplicationFacade.PERSON_ADDED: self.addPersonViewController.onAdded()
        default: break
        }
    }

}
