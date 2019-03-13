//
//  Example3FlowController.swift
//  Sample-RxSwift
//
//  Created by Ronaldo Gomes on 22/03/2016.
//  Copyright © 2016 it.technophile. All rights reserved.
//

import UIKit

class Example3FlowController {

    var navigationController:UINavigationController!
    
    convenience init(navigationController:UINavigationController) {
        self.init()
        self.navigationController = navigationController
    }
    
    func showExample3SecondViewController() {

        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Example3SecondViewController") as! Example3SecondViewController
        vc.delegate = self
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}

extension Example3FlowController: Example3SecondViewControllerDelegate {
    func example3SecondViewControlerDidReceiveTapOnDoneButton(example3SecondViewController:Example3SecondViewController) {
        self.navigationController.popViewControllerAnimated(true)
    }
}