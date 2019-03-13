//
//  PrepareModelCommand.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 4/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import puremvc

class PrepareModelCommand: SimpleCommand {
    
    override func execute(_ notification: INotification!) {
        
        let personProxy = PersonProxy()
        
        AppDelegate.dataStore.fetch({ people in
            personProxy.data = people
        })
        
        facade.register(personProxy)
        
    }

}
