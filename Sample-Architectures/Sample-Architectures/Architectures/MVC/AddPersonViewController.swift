//
//  AddPersonViewController.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 4/08/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import UIKit

protocol AddPersonDelegate {
    
    func didAddPerson(_ person:Person)
    
}

class AddPersonViewController: UIViewController {
    
    @IBOutlet fileprivate weak var nameTextField:UITextField!
    @IBOutlet fileprivate weak var emailTextField:UITextField!
    @IBOutlet fileprivate weak var ageTextField:UITextField!
    
    var delegate:AddPersonDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapCancelButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapDoneButton(_ sender: AnyObject) {
        
        let person = Person(
            name: self.nameTextField.text!,
            email: self.emailTextField.text!,
            age: Int(self.ageTextField.text!)!)

        do {
            try AppDelegate.dataStore.create(person) {
                self.delegate?.didAddPerson(person)
                self.dismiss(animated: true, completion: nil)
            }
        }
        catch {
        
        }
        
    }
    
}
