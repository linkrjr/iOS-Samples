//
//  DeletePersonCommand.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 6/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import puremvc

class DeletePersonCommand: SimpleCommand {
    
    override func execute(_ notification: INotification!) {

        if let personProxy = facade.retrieveProxy(PersonProxy.name()) as? PersonProxy,
            let person = notification.body() as? Person {
            personProxy.delete(person)
        }
        
    }
    
}
