//
//  ListPeopleViewController.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 4/08/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import UIKit

protocol PeopleListViewInput {
    func displayPeople(_ people: [Person])
}

class ListPeopleViewController: BaseListViewController, PeopleListViewInput {
    
    @IBOutlet weak var tableView:UITableView!
    
    var presenter: PeopleListViewOutput?
    
    fileprivate var people:[Person] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Riblets"        
        self.loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier
        
        if identifier == "AddPersonSegue" {
            
//            let navigationViewController = segue.destination as! UINavigationController
//            let addPersonViewController = navigationViewController.childViewControllers.first as! AddPersonViewController
//            addPersonViewController.delegate = self
            
        } else {
            
            //self.presenter
            
//            let cell = sender as! ListPeopleCell
//            let viewController = segue.destination as! ShowPersonViewController
//            viewController.person = cell.person
            
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.isEditing = editing
    }
    
    fileprivate func loadData() {
        self.presenter?.getPeople()
    }
    
    func displayPeople(_ people: [Person]) {
        self.people = people
    }
    
}

extension ListPeopleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            let person = self.people[indexPath.row]
            do {
                try AppDelegate.dataStore.delete(person, completionHandler: {
                    self.loadData()
                })
            }
            catch {}
            
        default:
            print("ignore other styles")
        }
    }
    
}

extension ListPeopleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! ListPeopleCell
        cell.person = self.people[indexPath.row]
    }
    
}

//extension ListPeopleViewController: AddPersonDelegate {
//    
//    func didAddPerson(_ person: Person) {
//        self.loadData()
//    }
//    
//}

