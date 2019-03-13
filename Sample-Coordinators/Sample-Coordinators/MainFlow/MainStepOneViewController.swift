//
//  ViewController.swift
//  Sample-Coordinators
//
//  Created by Ronaldo Gomes on 13/3/19.
//  Copyright © 2019 Ronaldo Gomes. All rights reserved.
//

import UIKit

protocol MainStepOneFlow {
    func didFinishStepOne()
    func didTapBranchOutButton()
}

class MainStepOneViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var flow: MainStepOneFlow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gr = UITapGestureRecognizer(target: self, action: #selector(MainStepOneViewController.didTapLabel))
        label.addGestureRecognizer(gr)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @objc func didTapLabel(label: AnyObject) {
        flow?.didFinishStepOne()
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        flow?.didTapBranchOutButton()
    }
    
}

