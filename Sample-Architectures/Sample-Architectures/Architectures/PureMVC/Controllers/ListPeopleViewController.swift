//
//  ListPeopleViewController.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 4/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import UIKit

class ListPeopleViewController: BaseListViewController {

    @IBOutlet weak var tableView:UITableView!
    
    var mediator: ListPeopleMediator?
    
    var people:[Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "PureMVC"
        
        self.mediator?.viewDidLoad()        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "AddPersonSegue" {
            self.mediator?.onNew()
        }
        
        return false
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.isEditing = editing
    }

    func reload() {
        self.tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = self.people[indexPath.row]
        self.mediator?.onSelect(person)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let person = self.people[indexPath.row]
            self.mediator?.onDelete(person)
            self.people.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
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
