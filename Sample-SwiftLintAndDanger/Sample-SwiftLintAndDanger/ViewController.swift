//
//  ViewController.swift
//  Sample-SwiftLintAndDanger
//
//  Created by Ronaldo Gomes on 14/2/19.
//  Copyright © 2019 Ronaldo Gomes. All rights reserved.
//

import UIKit

protocol MyProtocol: AnyObject {
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    func newMethod() {}
    
    func longMethod() {
        let longTuple: (String, Int, String, Int) = ("", 1, "", 1)
    }

}
