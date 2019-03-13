//
//  ApplicationFacade.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 3/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import puremvc

class ApplicationFacade: Facade {
    
    static var STARTUP = "startup"
    static var DELETE_PERSON = "deletePerson"
    static var NEW_PERSON = "newPerson"

    static var CREATE_PERSON = "createPerson"
    
    static var PERSON_SELECTED = "personSelected"
    static var PERSON_DELETED = "personDeleted"
    static var PERSON_ADDED = "personAdded"
    
    override func initializeController() {
        super.initializeController()
        
        registerCommand(ApplicationFacade.STARTUP, commandClassRef: StartupCommand.self)
        registerCommand(ApplicationFacade.DELETE_PERSON, commandClassRef: DeletePersonCommand.self)
        registerCommand(ApplicationFacade.CREATE_PERSON, commandClassRef: CreatePersonCommand.self)
        
    }
    
    static var sharedInstance: ApplicationFacade = {
        return ApplicationFacade.getInstance()
    }() as! ApplicationFacade
    
//    open class func getInstance() -> ApplicationFacade {
//        return super.getInstance { ApplicationFacade() } as! ApplicationFacade
//    }
    
    func startup(app: NavigationController) {
        sendNotification(ApplicationFacade.STARTUP, body: app)
    }
    
}
