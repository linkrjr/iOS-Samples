//
//  ShowPersonViewController.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 5/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import UIKit

class ShowPersonViewController: UIViewController {

    @IBOutlet fileprivate weak var nameLabel:UILabel!
    @IBOutlet fileprivate weak var emailLabel:UILabel!
    @IBOutlet fileprivate weak var ageLabel:UILabel!
    
    var person:Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let person = person else { return }
        self.title = person.name
        self.nameLabel.text = person.name
        self.emailLabel.text = person.email
        self.ageLabel.text = "\(person.age)"        
    }

}
