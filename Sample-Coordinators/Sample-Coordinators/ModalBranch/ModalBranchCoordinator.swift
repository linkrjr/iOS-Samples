//
//  ModalBranchCoordinator.swift
//  Sample-Coordinators
//
//  Created by Ronaldo Gomes on 13/3/19.
//  Copyright © 2019 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit

protocol ModalFlowCoordinator {
    func open(from: UIViewController)
}

class ModalBranchCoordinator: ModalFlowCoordinator, ModalBranchOneFlow {
    
    var navigation: UINavigationController
    
    private var vc1: UIViewController?
    
    init() {
        
        self.navigation = UINavigationController()
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        vc1 = storyboard.instantiateViewController(withIdentifier: "modal_branch_one")
        (vc1 as! ModalBranchOneViewController).flow = self
        
        self.navigation.viewControllers = [vc1!]
    }

    func open(from viewController: UIViewController) {
        viewController.present(self.navigation, animated: true, completion: nil)
    }
    
    func didTapCloseButton() {
        self.navigation.dismiss(animated: true, completion: nil)
    }
    
}
