//
//  AddPersonViewController.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 1/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController {

    @IBOutlet fileprivate weak var nameTextField:UITextField!
    @IBOutlet fileprivate weak var emailTextField:UITextField!
    @IBOutlet fileprivate weak var ageTextField:UITextField!
    
    var presenter: AddPersonPresenterProtocol?
    
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
        
        self.presenter?.save(person: person)
    }

}

extension AddPersonViewController: AddPersonViewProtocol {

    func didCreatePerson() {
        self.dismiss(animated: true, completion: nil)
    }

}
