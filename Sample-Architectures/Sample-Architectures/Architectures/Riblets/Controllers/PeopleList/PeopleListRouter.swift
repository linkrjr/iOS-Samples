//
//  PeopleListRouter.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 28/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation

enum PeopleListRouterType: Int {
    case show
}

class PeopleListRouter: RibletRouter {

    func attachView(routeType: PeopleListRouterType) {
        
        switch routeType {
        case .show:
            
            let builder = ShowPersonBuilder()
            
            let showPersonRiblet = builder.build(parentInteractor: self.riblet!.interactor)
            
            let context = Context(hashValue: routeType.rawValue)
            self.addChild(showPersonRiblet, to: context)
            
            if let childVC = showPersonRiblet.viewController {
                self.riblet?.viewController?.present(childVC, animated: true, completion: {
                    
                })
            }
            
        default:
            fatalError("Route not supported!!!")
        }
        
    }
    
}
