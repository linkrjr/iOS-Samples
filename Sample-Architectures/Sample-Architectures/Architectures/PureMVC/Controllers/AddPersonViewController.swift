//
//  AddPersonViewController.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 7/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController {

    @IBOutlet fileprivate weak var nameTextField: UITextField!
    @IBOutlet fileprivate weak var emailTextField: UITextField!
    @IBOutlet fileprivate weak var ageTextField: UITextField!
    
    var mediator: AddPersonMediator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mediator?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mediator?.viewWillAppear(animated)
    }
    
    @IBAction func didTapCancelButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapDoneButton(_ sender: AnyObject) {
        
        let person = Person(
            name: self.nameTextField.text!,
            email: self.emailTextField.text!,
            age: Int(self.ageTextField.text!)!)
        
        self.mediator?.onCreate(person)
        
    }
    
    func onAdded() {
        self.dismiss(animated: true, completion: nil)
    }

    func resetForm() {
        self.nameTextField.text = ""
        self.emailTextField.text = ""
        self.ageTextField.text = ""
    }
    
}
