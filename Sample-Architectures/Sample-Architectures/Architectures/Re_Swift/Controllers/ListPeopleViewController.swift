//
//  ListPeopleViewController.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 7/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter
//import ListKit
import PKHUD

class ListPeopleViewController: BaseListViewController, StoreSubscriber {
    
    typealias StoreSubscriberStateType = PeopleState
    
    @IBOutlet weak var tableView:UITableView!
    
    fileprivate var people:[Person] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ReSwift"

        store.subscribe(self) { subcription in
            subcription.select { $0.people }
        }
        store.dispatch(fetchPeople())
        
        self.tableView.accessibilityLabel = "People List"
        self.tableView.isAccessibilityElement = true
    }
    
    deinit {
        store.unsubscribe(self)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "AddPersonSegue" {
            let newRoute = [mainViewRoute, addPersonRoute]
            let routeAction = ReSwiftRouter.SetRouteAction(newRoute)
            store.dispatch(routeAction)
        }
        
        return false
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.isEditing = editing
    }
    
    func newState(state: PeopleState) {
        switch state {
        case .loading:
            HUD.show(.progress)
        case .finished(let people):
            HUD.hide()
            self.people = people
        case .deleted, .added:
            store.dispatch(fetchPeople())
            break
        }
    }
    
}

extension ListPeopleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: store.dispatch(DeletePersonAction(person: self.people[indexPath.row]))
        default: print("ignore other styles")
        }
    }
    
}

extension ListPeopleViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPerson = self.people[indexPath.row]
        let newRoute = [mainViewRoute, personDetailsRoute]
        
        let routeAction = ReSwiftRouter.SetRouteAction(newRoute)
        let setDataAction = ReSwiftRouter.SetRouteSpecificData(route: newRoute, data: selectedPerson)
        
        store.dispatch(setDataAction)
        store.dispatch(routeAction)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! ListPeopleCell
        cell.person = self.people[indexPath.row]
    }
    
}
