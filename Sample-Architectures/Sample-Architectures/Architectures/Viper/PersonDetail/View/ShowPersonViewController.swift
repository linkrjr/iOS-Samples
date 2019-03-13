//
//  ShowPersonViewController.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 1/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import UIKit

class ShowPersonViewController: UIViewController {

    @IBOutlet fileprivate weak var nameLabel:UILabel!
    @IBOutlet fileprivate weak var emailLabel:UILabel!
    @IBOutlet fileprivate weak var ageLabel:UILabel!
    
    var presenter: PersonDetailPresenterProtocol?
    
    var person:Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
    
}

extension ShowPersonViewController: PersonDetailViewProtocol {

    func showPersonDetail(for person: Person) {
        self.nameLabel.text = person.name
        self.emailLabel.text = person.email
        self.ageLabel.text = "\(person.age)"
    }
    
}
