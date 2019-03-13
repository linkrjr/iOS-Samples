//
//  PrepareViewCommand.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 4/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import puremvc

class PrepareViewCommand: SimpleCommand {
    
    override func execute(_ notification: INotification!) {

        if let app = notification.body() as? NavigationController {
            facade.register(NavigationMediator(viewComponent: app))
        }
        
    }
    
}
