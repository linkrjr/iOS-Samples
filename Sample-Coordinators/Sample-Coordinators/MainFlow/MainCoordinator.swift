//
//  MainCoordinator.swift
//  Sample-Coordinators
//
//  Created by Ronaldo Gomes on 13/3/19.
//  Copyright © 2019 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: FlowCoordinator, MainStepOneFlow, MainStepTwoFlow {
    
    private var vc1: UIViewController?
    private var vc2: UIViewController?
    
    var viewController: UINavigationController
    
    var branch: FlowCoordinator?
    var modal: ModalFlowCoordinator?
    
    let window: UIWindow
    
    @discardableResult
    init(window: UIWindow) {
        self.window = window
    
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        self.viewController = UINavigationController()
        
        self.branch = BranchCoordinator(viewController: viewController)
        self.modal = ModalBranchCoordinator()
        
        vc1 = storyboard.instantiateViewController(withIdentifier: "main_step_one")
        (vc1 as! MainStepOneViewController).flow = self
        
        vc2 = storyboard.instantiateViewController(withIdentifier: "main_step_two")
        (vc2 as! MainStepTwoViewController).flow = self
        
        viewController.viewControllers = [vc1!]
        
    }
    
    func start() {
        window.rootViewController = self.viewController
        window.makeKeyAndVisible()
    }
    
    func didFinishStepOne() {
        viewController.pushViewController(vc2!, animated: true)
    }
    
    func didTapBranchOutButton() {
        self.branch?.start()
    }
    
    func didTapModalButton() {
        modal?.open(from: self.viewController)
    }
    
}
