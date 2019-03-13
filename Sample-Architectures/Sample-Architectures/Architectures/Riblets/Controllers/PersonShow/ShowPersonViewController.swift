//
//  ShowPersonViewController.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 4/08/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import UIKit

protocol ShowPersonViewInput {
    
}

protocol ShowPersonViewOutput {
    
}


class ShowPersonViewController: UIViewController, ShowPersonViewInput {
    
    @IBOutlet fileprivate weak var nameLabel:UILabel!
    @IBOutlet fileprivate weak var emailLabel:UILabel!
    @IBOutlet fileprivate weak var ageLabel:UILabel!
    
    var presenter: ShowPersonViewOutput?
    
    var person:Person?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let person = person else { return }
        self.nameLabel.text = person.name
        self.emailLabel.text = person.email
        self.ageLabel.text = "\(person.age)"
        
    }
    
}
