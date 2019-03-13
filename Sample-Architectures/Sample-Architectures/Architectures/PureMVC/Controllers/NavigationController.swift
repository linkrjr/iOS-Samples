//
//  NavigationController.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 5/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    weak var mediator: NavigationMediator?

    var peopleList: ListPeopleViewController!
    var personDetails: ShowPersonViewController!
    var personForm: AddPersonViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.peopleList = self.viewControllers.first as! ListPeopleViewController
        self.personDetails = self.storyboard?.instantiateViewController(withIdentifier: "ShowPersonViewController") as! ShowPersonViewController
        self.personForm = self.storyboard?.instantiateViewController(withIdentifier: "AddPersonViewController") as! AddPersonViewController
        
        self.mediator?.viewDidLoad()
    }
    
    func showPersonDetails(_ person: Person) {
        self.personDetails.person = person
        self.pushViewController(self.personDetails, animated: true)
    }
    
    func showPersonForm() {
        let navigation = self.storyboard?.instantiateViewController(withIdentifier: "AddPersonNavigationController") as! UINavigationController
        navigation.viewControllers.append(self.personForm)
        self.present(navigation, animated: true, completion: nil)
    }

}
