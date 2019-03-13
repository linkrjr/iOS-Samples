//
//  ListPeopleViewController.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 6/12/16.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import UIKit
import PKHUD

class ListPeopleViewController: BaseListViewController {

    @IBOutlet weak var tableView:UITableView!
    
    var presenter: ListPeoplePresenterProtocol?
    
    var people: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Viper"
        self.presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewWillAppear()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddPersonSegue" {
            
            self.presenter?.showAddPersonForm(to: segue)
            
        } else {
            
            if let cell = sender as? ListPeopleCell, let person = cell.person {
                self.presenter?.showPersonDetail(for: person, to: segue)
            }
            
        }
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.isEditing = editing
    }

}

extension ListPeopleViewController: ListPeopleViewProtocol {

    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.hide()
    }
    
    func showPeople(_ people: [Person]) {
        self.people = people
        self.tableView.reloadData()
    }
    
    func didRemovePerson() {
        self.presenter?.reloadPeopleList()
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
        case .delete:
            let person = self.people[indexPath.row]
            self.presenter?.remove(person)
            
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


