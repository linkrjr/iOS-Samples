//
//  Example2ViewController.swift
//  Sample-RxSwift
//
//  Created by Ronaldo GomesJr on 7/03/2016.
//  Copyright © 2016 it.technophile. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct OddsOrEven {
    
    var value:Int
    
    func isEven() -> Bool {
        return self.value % 2 == 0
    }

    func isOdd() -> Bool {
        return !self.isEven()
    }
    
}

class Example2ViewController: UIViewController {

    @IBOutlet var textField:UITextField!
    @IBOutlet var label:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let sub = self.textField.rx_text.map { OddsOrEven(value: Int($0) ?? 0) }
            .map { "number \($0.value) is odd? \($0.isOdd())" }.bindTo(self.label.rx_text)

        sub
    }

}
