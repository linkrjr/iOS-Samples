//
//  MainStepTwoViewController.swift
//  Sample-Coordinators
//
//  Created by Ronaldo Gomes on 13/3/19.
//  Copyright © 2019 Ronaldo Gomes. All rights reserved.
//

import UIKit

protocol MainStepTwoFlow {
    func didTapModalButton()
}

class MainStepTwoViewController: UIViewController {

    var flow: MainStepTwoFlow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func didTapModalButton(_ sender: Any) {
        flow?.didTapModalButton()
    }
    
}
