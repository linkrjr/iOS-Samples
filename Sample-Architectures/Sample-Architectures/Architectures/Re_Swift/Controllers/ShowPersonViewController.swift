//
//  ShowPersonViewController.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 4/08/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class ShowPersonViewController: UIViewController, StoreSubscriber {
    
    typealias StoreSubscriberStateType = (Person?)
    
    @IBOutlet fileprivate weak var nameLabel:UILabel!
    @IBOutlet fileprivate weak var emailLabel:UILabel!
    @IBOutlet fileprivate weak var ageLabel:UILabel!
    
    var person:Person? {
        didSet {
            guard let person = person else { return }
            self.nameLabel.text = person.name
            self.emailLabel.text = person.email
            self.ageLabel.text = "\(person.age)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.subscribe(self) { state in
        
            state.select({ currentState in
                let currentPerson: Person? = currentState.navigationState.getRouteSpecificState(
                    currentState.navigationState.route
                )
                return (currentPerson)
            })
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        store.unsubscribe(self)
    }
    
    //MARK: This is a max drawback in this architecture
    override func didMove(toParentViewController parent: UIViewController?) {
        if parent == nil {
            // Required to update the route, when this VC was dismissed through back button from
            // NavigationController, since we can't intercept the back button
            if store.state.navigationState.route == [mainViewRoute, personDetailsRoute] {
                store.dispatch(SetRouteAction([mainViewRoute]))
            }
        }
    }
    
    func newState(state: StoreSubscriberStateType) {
        self.person = state
    }
    
}
