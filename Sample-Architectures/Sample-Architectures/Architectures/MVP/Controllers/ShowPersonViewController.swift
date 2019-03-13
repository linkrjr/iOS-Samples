//
//  ShowPersonViewController.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 27/07/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import UIKit

class ShowPersonViewController: UIViewController {
    
    @IBOutlet fileprivate weak var nameLabel:UILabel!
    @IBOutlet fileprivate weak var emailLabel:UILabel!
    @IBOutlet fileprivate weak var ageLabel:UILabel!

    var presenter: ShowPersonPresenter?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nameLabel.text = self.presenter!.nameText
        self.emailLabel.text = self.presenter!.emailText
        self.ageLabel.text = self.presenter!.ageText
        
    }

}
