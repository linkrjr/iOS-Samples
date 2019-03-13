//
//  AddPersonViewController.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 27/07/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import UIKit

protocol AddPersonDelegate {
    func didFinishCreatingPerson(_ person: Person)
}

class AddPersonViewController: UIViewController {

    @IBOutlet fileprivate weak var nameTextField:UITextField!
    @IBOutlet fileprivate weak var emailTextField:UITextField!
    @IBOutlet fileprivate weak var ageTextField:UITextField!
    
    var delegate: AddPersonDelegate?
    var presenter: AddPersonPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = AddPersonPresenter()
    }
    
    @IBAction func didTapDoneButton(_ sender:AnyObject) {
        
        let person = Person(
            name: self.nameTextField.text!,
            email: self.emailTextField.text!,
            age: Int(self.ageTextField.text!)!)
        
        self.presenter?.createPerson(person)
    
    }

    @IBAction func didTapCancelButton(_ sender:AnyObject) {
        self.dismiss(animated: true, completion: nil)    
    }
    
}

extension AddPersonViewController: AddPersonViewPort {
    
    func didCreate(_ person: Person) {
        self.delegate?.didFinishCreatingPerson(person)
        self.dismiss(animated: true, completion: nil)
    }
    
}
