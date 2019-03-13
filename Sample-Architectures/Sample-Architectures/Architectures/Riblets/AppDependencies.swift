//
//  AppDependencies.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 28/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies {

    var rootRiblet: Riblet?
    var rootInteractor: Interactor?
    
    func configRootView(window: UIWindow, forLaunchOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
    
        let builder = PeopleListBuilder()
        self.rootRiblet = builder.build()
        
        self.rootInteractor = self.rootRiblet?.interactor as? PeopleListInteractor
        
        if let vc = self.rootRiblet?.viewController {
            window.rootViewController = NavigationController(rootViewController: vc)
            window.makeKeyAndVisible()
        }
        
    }
    
}
