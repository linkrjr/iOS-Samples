//
//  StartupCommand.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 4/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import puremvc

class StartupCommand: MacroCommand {

    override func initializeMacroCommand() {
        
        addSubCommand(PrepareModelCommand.self)
        addSubCommand(PrepareViewCommand.self)
        
    }

}
