//
//  AddPersonViewController.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 27/07/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import UIKit

protocol AddPersonDelegate {
    func didFinishCreatingPerson(_ person:Person)
}

class AddPersonViewController: UIViewController {

    @IBOutlet fileprivate weak var nameTextField:UITextField!
    @IBOutlet fileprivate weak var emailTextField:UITextField!
    @IBOutlet fileprivate weak var ageTextField:UITextField!
    
    var delegate:AddPersonDelegate?
    var viewModel:AddPersonViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = AddPersonViewModel()
        
        self.viewModel?.didCreatePerson = { person in
            self.delegate?.didFinishCreatingPerson(person)
            self.dismiss(animated: true, completion: nil)
        }        
    }
    
    @IBAction func didTapDoneButton(_ sender:AnyObject) {
        
        let person = Person(
            name: self.nameTextField.text!,
            email: self.emailTextField.text!,
            age: Int(self.ageTextField.text!)!)
        
        self.viewModel?.createPerson(person)
    
    }

    @IBAction func didTapCancelButton(_ sender:AnyObject) {
        self.dismiss(animated: true, completion: nil)    
    }
    
}
