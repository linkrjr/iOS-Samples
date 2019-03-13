//
//  ListPeopleViewController.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 4/04/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import UIKit

class ListPeopleViewController: BaseListViewController {
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    fileprivate var presenter: ListPeoplePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MVP"
        
        self.presenter = ListPeoplePresenter(viewPort: self)
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.isEditing = editing
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddPersonSegue" {
            
            //MARK: Add a person
            let navigationViewController = segue.destination as! UINavigationController
            let addPersonViewController = navigationViewController.childViewControllers.first as! AddPersonViewController
            addPersonViewController.delegate = self
            
        } else {
            
            //MARK: Show a person's details
            let viewController = segue.destination as! ShowPersonViewController
            viewController.presenter = ShowPersonPresenter(person: self.presenter!.fetchPersonByIndexPath(self.tableView.indexPathForSelectedRow!))
            
        }
        
    }
    
}

extension ListPeopleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            self.presenter!.removePersonAt(IndexPath: indexPath)
            
        default:
            print("ignore any other editing style")
        }
        
    }
    
}

extension ListPeopleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! ListPeopleCell
        //REFACTOR: Should probably not be dealing with the Person model here in the VienController
        // VCs shouldn't know anything about models         
        //cell.person = self.presenter!.fetchPersonByIndexPath(indexPath)
        
        cell.textLabel!.text = self.presenter!.nameAndAgeForIndexPath(indexPath)
        
    }

}

extension ListPeopleViewController: AddPersonDelegate {

    func didFinishCreatingPerson(_ person: Person) {
        self.presenter!.loadPeople()
    }
    
}

extension ListPeopleViewController: ListPeopleViewPort {
    
    func loaded() {
        self.tableView.reloadData()
    }
    
}

