//
//  ModalBranchOneViewController.swift
//  Sample-Coordinators
//
//  Created by Ronaldo Gomes on 13/3/19.
//  Copyright © 2019 Ronaldo Gomes. All rights reserved.
//

import UIKit

protocol ModalBranchOneFlow {
    func didTapCloseButton()
}

class ModalBranchOneViewController: UIViewController {

    var flow: ModalBranchOneFlow?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func didTapCloseButton(_ sender: Any) {
        flow?.didTapCloseButton()
    }

}
