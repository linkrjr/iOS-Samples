//
//  BranchCoordinator.swift
//  Sample-Coordinators
//
//  Created by Ronaldo Gomes on 13/3/19.
//  Copyright © 2019 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit

class BranchCoordinator: FlowCoordinator {
    
    private var vc1: UIViewController?
    
    var viewController: UINavigationController
    
    init(viewController: UINavigationController) {
        self.viewController = viewController
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        vc1 = storyboard.instantiateViewController(withIdentifier: "branch_one")
    }
    
    func start() {
        self.viewController.pushViewController(vc1!, animated: true)
    }
    
}
